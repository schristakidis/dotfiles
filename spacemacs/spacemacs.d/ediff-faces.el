(with-eval-after-load 'ediff
  (set-face-attribute ediff-even-diff-face-A nil :background "dark slate grey")
  (set-face-attribute ediff-even-diff-face-B nil :background "dark slate gray")
  (set-face-attribute ediff-fine-diff-face-B nil :background "saddle brown")
  (set-face-attribute ediff-odd-diff-face-A nil :background "gray15")
  (set-face-attribute ediff-odd-diff-face-B nil :background "gray15"))

(provide 'ediff-faces)
