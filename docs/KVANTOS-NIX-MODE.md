# KvantOS Dual-Mode: AUR / Nix

KvantOS — Arch-based дистрибутив. При установке пользователь **обязан**
выбрать режим системы — без выбора установка не продолжается.

## Режим AUR (классический)

Стандартный сценарий Arch/CachyOS: пакеты ставятся в систему через
`pacman` (+ AUR-хелпер по вкусу). Обновления — императивные, как обычно.

## Режим Nix (декларативный пользовательский стек)

Поверх KvantOS устанавливаются `nix` и `git`. Пользовательское окружение
(редакторы, тулчейн) описывается декларативно в `flake.nix` / `home.nix`
и применяется через `home-manager` из `nixpkgs` unstable.
Это **не** NixOS поверх Arch — система остаётся Arch-based.

## Как реализовано в установщике

- `packagechooser@kvantos-mode` (`packagechooser_kvantos_mode.conf`),
  шаг стоит **до** выбора окружения рабочего стола, `mode: required`,
  дефолта нет. Карточки: «AUR» и «Nix».
- `method: netinstall-select`: выбор карточки Nix включает одноимённую
  группу «Декларативный стек (Nix)» (`nix`, `git`) на шаге «Пакеты».

## Шаблоны

В установленной системе (и в `/etc/skel` для новых пользователей):

- `/etc/skel/kvantos/flake.nix` — home-manager flake, `nixpkgs`
  `nixos-unstable`, профиль: vscodium, rustup, jupyterlab, git.
  Плейсхолдеры `@USER@` / `@HOME@` подставляются при инициализации.
- `/etc/skel/kvantos/home.nix` — сама home-конфигурация.

## Команда `kvantos-mode`

```
kvantos-mode status        # текущий режим (/etc/kvantos/mode, автодетект)
kvantos-mode use nix       # режим nix + инициализация flake из шаблонов
kvantos-mode use aur       # режим aur
kvantos-mode gc            # nix-collect-garbage -d + nix-store --optimise
```

В live-сессии `status` показывает `live`.

## Интеграция с KvantOS Hello

Окно приветствия показывает текущий режим (карточка на главной странице)
с кнопкой-объяснением, что означают режимы и как переключиться.
