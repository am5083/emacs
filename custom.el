(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ts-fold-replacement-face ((t (:foreground nil :box nil :inherit font-lock-comment-face :weight light)))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((projectile-project-run-cmd . "cmake --build . && ./coca-engine ")
     (projectile-project-compilation-dir . "./cmake-build-debug/")
     (projectile-project-run-cmd . "cmake --build . && ./yayo")
     (projectile-project-compilation-cmd . "cmake -DCMAKE_BUILD_TYPE=Debug .. && cmake --build .")
     (projectile-project-configure-cmd . "cmake -DCMAKE_BUILD_TYPE=Release .. && cmake --build .")
     (projectile-project-compilation-dir . "./build/"))))
