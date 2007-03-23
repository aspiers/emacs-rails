;;; rails-model-layout.el ---

;; Copyright (C) 2006 Galinsky Dmitry <dima dot exe at gmail dot com>

;; Keywords: ruby rails languages oop
;; $URL: svn+ssh://rubyforge/var/svn/emacs-rails/trunk/rails-for-rhtml.el $
;; $Id: rails-for-rhtml.el 58 2006-12-17 21:47:39Z dimaexe $

;;; License

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 2
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

;;; Code:

(defun rails-model-layout:switch-to (type)
  (let* ((model (rails-core:current-model))
         (item (case type
                 (:controller (rails-core:controller-file (pluralize-string model)))
                 (:fixture (rails-core:fixture-file model))
                 (:unit-test (rails-core:unit-test-file model))
                 (:model (rails-core:model-file model)))))
    (rails-core:find-file-if-exist item)))

(defun rails-model-layout:menu ()
  (interactive)
  (let* ((item (list))
         (type (rails-core:buffer-type))
         (title (capitalize (substring (symbol-name type) 1)))
         (model (rails-core:current-model))
         (controller (pluralize-string model)))
    (when (rails-core:controller-exist-p controller)
      (setq item (add-to-list 'item (cons "Controller" :controller))))
    (unless (eq type :fixture)
      (setq item (add-to-list 'item (cons "Fixture" :fixture))))
    (unless (eq type :unit-test)
      (setq item (add-to-list 'item (cons "Unit test" :unit-test))))
    (unless (eq type :model)
      (setq item (add-to-list 'item (cons "Model" :model))))
    (setq item
          (rails-core:menu
           (list (concat title " " model)
                 (cons "Please select.."
                       item))))
    (when item
      (rails-model-layout:switch-to item))))

(provide 'rails-model-layout)