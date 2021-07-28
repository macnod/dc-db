(asdf:defsystem :dc-db
  :depends-on (:postmodern :dc-utilities)
  :serial t
  :components ((:file "package")
	       (:file "dc-db")))
