; Face for None, True, False, self, and Ellipsis
;; (defvar py-pseudo-keyword-face 'py-pseudo-keyword-face
;;   "Face for pseudo keywords in Python mode, like self, True, False, Ellipsis.")
;; (make-face 'py-pseudo-keyword-face)

;; PEP 318 decorators
;; (defvar py-decorators-face 'py-decorators-face
;;   "Face method decorators.")
;; (make-face 'py-decorators-face)

;; ;; Face for builtins
;; (defvar py-builtins-face 'py-builtins-face
;;   "Face for builtins like TypeError, object, open, and exec.")
;; (make-face 'py-builtins-face)

;; ;; Face for python self
;; (defvar py-self-face 'py-self-face
;;   "Face for types like dict,list")
;; (make-face '
 ;; py-self-face)

;; XXX, TODO, and FIXME comments and such
;; (defvar py-XXX-tag-face 'py-XXX-tag-face
;;   "Face for XXX, TODO, and FIXME tags")
;; (make-face 'py-XXX-tag-face)

;; (defun py-font-lock-mode-hook ()
;;   (or (face-differs-from-default-p 'py-pseudo-keyword-face)
;;       (copy-face 'font-lock-type-face 'py-pseudo-keyword-face))
;;   (or (face-differs-from-default-p 'py-builtins-face)
;;       (copy-face 'font-lock-function-name-face 'py-builtins-face))
;;   (or (face-differs-from-default-p 'py-self-face)
;;       (copy-face 'font-lock-function-name-face 'py-self-face))
;;   (or (face-differs-from-default-p 'py-decorators-face)
;;       (copy-face 'font-lock-type-face 'py-decorators-face))
;;   (or (face-differs-from-default-p 'py-XXX-tag-face)
;;       (copy-face 'font-lock-comment-face 'py-XXX-tag-face))
;;   )
;; (add-hook 'font-lock-mode-hook 'py-font-lock-mode-hook)


(defvar python-font-lock-keywords
  (let ((kw1 (mapconcat 'identity
			'("and"      "assert"   "break"   "class"
			  "continue" "def"      "del"     "elif"
			  "else"     "except"   "exec"    "for"
			  "global"   "if"
			  "in"       "is"       "lambda"  "not"
			  "or"       "pass"     "print"   "raise"
			  "return"   "while"    "with"    "yield"
			  )
			"\\|"))
	(kw2 (mapconcat 'identity
			'("else:" "except:" "finally:" "try:")
			"\\|"))
	(kw3 (mapconcat 'identity
			;; Don't include True, False, None, or
			;; Ellipsis in this list, since they are
      ;; already defined as pseudo keywords.
      '("abs" "all" "any" "bin" "callable" "chr" "classmethod"
      "compile" "complex" "delattr"  "dir" "divmod" "enumerate"
      "eval" "filter"  "format" "frozenset" "getattr" "globals"
      "hasattr" "hash" "help" "hex" "id" "input"  "isinstance"
      "issubclass" "iter" "len"  "locals" "map" "max" "memoryview"
      "min" "next" "oct" "open" "ord" "pow" "print" "property"
      "range" "repr" "reversed" "round" "set" "setattr" "slice" "sorted"
      "staticmethod"  "sum" "super"  "vars" "zip"
      "__import__" "__debug__"
      ;; Python 2:
      "basestring" "cmp" "execfile" "file" "long" "raw_input" "reduce"
      "reload" "unichr" "unicode" "xrange" "apply" "buffer" "coerce"
      "intern"
      ;; Python 3:
      "ascii" "bytearray" "bytes" "exec"
      ;; Extra:
      "__all__" "__doc__" "__name__" "__package__")
			"\\|"))
	(kw4 (mapconcat 'identity
			;; Exceptions and warnings
      '("ArithmeticError" "AssertionError" "AttributeError" "BaseException"
        "DeprecationWarning" "EOFError" "EnvironmentError" "Exception"
        "FloatingPointError" "FutureWarning" "GeneratorExit" "IOError"
        "ImportError" "ImportWarning" "IndexError" "KeyError"
        "KeyboardInterrupt" "LookupError" "MemoryError" "NameError"
        "NotImplementedError" "OSError" "OverflowError"
        "PendingDeprecationWarning" "ReferenceError" "RuntimeError"
        "RuntimeWarning" "StopIteration" "SyntaxError" "SyntaxWarning"
        "SystemError" "SystemExit" "TypeError" "UnboundLocalError"
        "UnicodeDecodeError" "UnicodeEncodeError" "UnicodeError"
        "UnicodeTranslateError" "UnicodeWarning" "UserWarning" "VMSError"
        "ValueError" "Warning" "WindowsError" "ZeroDivisionError"
        ;; Python 2:
        "StandardError"
        ;; Python 3:
        "BufferError" "BytesWarning" "IndentationError" "ResourceWarning"
        "TabError")
			"\\|"))
  	(kw5 (mapconcat 'identity
        '("type" "int" "float" "tuple" "str" "dict" "list" "bool")
  			"\\|"))
	)
    (list
     '("\\([@$]+\\)" 1 font-lock-preprocessor-face)
     '("^[ \t]*@\\(.+\\)\\>[ \n\t(]" 1 'font-lock-function-name-face)
     ;; keywords
     (cons (concat "\\<\\(" kw1 "\\)\\>[ \n\t(]") 1)
     ;; builtins when they don't appear as object attributes
     (list (concat "\\([^. \t]\\|^\\)[ \t]*\\<\\(" kw3 "\\)\\>[ \n\t(]") 2
	   'font-lock-function-name-face)
     ;; block introducing keywords with immediately following colons.
     ;; Yes "except" is in both lists.
     (cons (concat "\\<\\(" kw2 "\\)[ \n\t(]") 1)
     ;; Exceptions
     (list (concat "\\<\\(" kw4 "\\)[ \n\t:,(]") 1 'font-lock-function-name-face)
     (list (concat "\\<\\(" kw5 "\\)[ \n\t:,(]") 1 'font-lock-type-face)
     ;; `as' but only in "import foo as bar" or "with foo as bar"
     '("[ \t]*\\(\\<from\\>.*\\)?\\<import\\>.*\\<\\(as\\)\\>" . 2)
     '("[ \t]*\\<with\\>.*\\<\\(as\\)\\>" . 1)
     ;; classes
     '("\\<class[ \t]+\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)" 1 font-lock-type-face)
     ;; functions
     '("\\<def[ \t]+\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)"
       1 font-lock-function-name-face)
     ;; pseudo-keywords
     '("\\<\\(None\\|True\\|False\\|Ellipsis\\|object\\)\\>"
       1 font-lock-type-face)
     '("\\<\\(self\\)\\>" 1 font-lock-function-name-face)
     '("\\<\\(from\\|import\\)\\>" 1 font-lock-preprocessor-face)
     ;; XXX, TODO, and FIXME tags
     '("XXX\\|TODO\\|FIXME" 0 font-lock-type-face t)
     ;; operators
     '("\\([|!+=&/%*^<>-]+\\)" 1 font-lock-keyword-face)
     ))
  "Additional expressions to highlight in Python mode.")


(with-eval-after-load 'python-mode
  (put 'python-mode 'font-lock-defaults '(python-font-lock-keywords))
  )


(provide 'python-faces)
