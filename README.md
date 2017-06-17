# DC-DB
## License
MIT License

Copyright (c) 2017 Donnie Cameron

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

## API
### macro  db-cmd 
(**&REST** **ARGS**)

This function executes a database command. The DS parameter is a ds data structure with the following self-describing key value pairs: :db, :username, :password, :host, :retry-count, :retry-sleep,:retry-sleep-factor, and :log-function. The :retry-sleep value is an integer that represents the number seconds to sleep after the first try. Subsequent tries multiply the last amount of sleep time by the value of :retry-sleep-factor. The log function you provide must accept a single string as a parameter. The DB-COMMAND and PARAMS parameters are a standard postmodern database command with parameters. All the parameters are required.

