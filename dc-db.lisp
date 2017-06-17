(defpackage :dc-db
  (:use :cl :postmodern :dc-utilities)
  (:export :db-cmd))

(in-package :dc-db)

(defmacro db-cmd (ds db-command &rest params)
  "This function executes a database command.  The DS parameter is a ds data structure with the following self-describing key value pairs: :db, :username, :password, :host, :retry-count, :retry-sleep,:retry-sleep-factor, and :log-function.  The :retry-sleep value is an integer that represents the number seconds to sleep after the first try.  Subsequent tries multiply the last amount of sleep time by the value of :retry-sleep-factor.  The log function you provide must accept a single string as a parameter.  The DB-COMMAND and PARAMS parameters are a standard postmodern database command with parameters.  All the parameters are required."
  `(loop with log = (ds-get ,ds :log-function)
      for retries-left = (1- (ds-get ,ds :retry-count)) then (1- retries-left)
      for retry-sleep = (ds-get ,ds :retry-sleep) then
        (* retry-sleep (ds-get ,ds :retry-sleep-factor))
      for result =
        (handler-case
            (postmodern:with-connection
                (append
                 (mapcar (lambda (x) (ds-get ,ds x))
                         '(:db :username :password :host))
                 (list :pooled-p t))
              (,(intern (symbol-name db-command) "POSTMODERN") ,@params))
          (error (e)
            (funcall 
             log 
             (format nil "Error in database connection during try ~d"
                     (- (ds-get ,ds :retry-count) retries-left)))
            (funcall log (format nil "~a" e))
            :error))
      while (and (equal result :error) (not (zerop retries-left)))
      do
        (funcall log (format nil "Retrying in ~a seconds" retry-sleep))
        (sleep retry-sleep)
      finally (return result)))
