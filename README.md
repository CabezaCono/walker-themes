# walker dotfiles

Personal dotfiles for configuring [walker](https://github.com/abenz1267/walker), focused on:

- Custom theme selection
- A theming workflow based on reusable color schemes
- Scripts to build walker themes from those schemes

> The base `config.toml` is essentially the default one from walker,  
> with the theme set to my generated theme.

---

## Overview

Typical layout (conceptual):

```text
~/.config/walker
├── config.toml                # Main walker configuration (mostly default)
├── colors/                    # Base color schemes (palettes)
├── themes/
│   ├── neo/                   # Example / source theme
│   └── current/               # Currently active, built theme
├── previews/                  # Theme preview images
└── scripts/
    └── build-theme-with-color-scheme.sh
```

- `config.toml` is basically walker’s default config, except for:

  ```toml
  theme = "current"               # theme to use
  ```

- `colors/` contains the color schemes you can apply to your themes.
- `themes/` holds the actual theme folders that walker can load.
- `previews/` stores screenshots for each theme.
- `scripts/build-theme-with-color-scheme.sh` builds a concrete theme (e.g. `themes/current/`) from a color scheme in `colors/`.

---

## Themes

A simple overview of the themes I’ve created so far.

<details>
  <summary><strong>neo</strong></summary>

  ### Neo (Default color scheme)

  ![neo theme preview](previews/neo-default.png)

</details>

### Preview file structure for current and future themes

To keep previews consistent for the current theme and any future ones:

- Store all screenshots under the `previews/` directory.
- Use the theme name as the base filename.

Recommended pattern:

```text
previews/
├── neo.png          # main preview for "neo"
├── neo-thumb.png    # optional thumbnail
├── tokyonight.png   # future theme example
└── tokyonight-thumb.png
```

And reference them in the README like:

```markdown
![<theme> theme preview](previews/<theme>.png)
```

For example, if later you add a `tokyonight` theme:

```markdown
![tokyonight theme preview](previews/tokyonight.png)
```

---

## Theming & Color Schemes

The theming system is split into:

1. **Color schemes** under `colors/`  
   Reusable palettes: accent, foreground, background, error colors, etc.

2. **Theme templates** under `themes/`  
   For example, `themes/neo/` can act as a base theme that gets its colors from a scheme.

3. **Built themes** (e.g. `themes/current/`)  
   The build script takes a color scheme from `colors/`, applies it to a base theme and outputs a ready-to-use theme folder.  
   `config.toml` then points to this folder via:

   ```toml
   theme = "current"
   ```

This separation lets you:

- Reuse the same palette across multiple theme variants.
- Change schemes centrally without editing big CSS/JSON files manually.
- Quickly experiment with different color schemes by rebuilding the theme.

---

## Build script

The script that ties schemes and themes together is:

```bash
~/.config/walker/scripts/build-theme-with-color-scheme.sh <COLOR_SCHEME> <THEME>
```
Example:

```bash
~/.config/walker/scripts/build-theme-with-color-scheme.sh tokyo-night neo
```

Typical responsibilities:

- Read a scheme from `colors/`
- Apply it to a base theme (e.g. `themes/neo/`)
- Generate a final theme (e.g. `themes/current/`)

After generating the theme, make sure `config.toml` points to it:

```toml
theme = "current"
```

---

## Installation

1. **Clone** this repo into your walker config directory:

```bash
git clone https://github.com/CabezaCono/walker-themes.git ~/.config/walker
```

Or clone elsewhere and symlink:

```bash
ln -s /path/to/your/repo ~/.config/walker
```

2. **Build the theme** you want (if your script requires args, adjust accordingly):

```bash
cd ~/.config/walker
./scripts/build-theme-with-color-scheme.sh
```

3. **Run walker**; it will use `config.toml` (mostly default) and your generated theme.

---

## Customization ideas

- Add new color schemes under `colors/`.
- Create additional theme templates under `themes/` and reuse the same schemes.
- Extend `build-theme-with-color-scheme.sh` to:
  - Support multiple output themes
  - Generate matching styles for other tools (terminal, GTK, etc.)

---

## License

These configuration files are provided as-is.  
Use them freely as reference or as a base for your own dotfiles.
