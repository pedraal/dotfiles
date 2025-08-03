mkdir -p ~/.config

for entry in */; do
  dir="${entry%/}"

  [[ "$dir" == ".git" ]] && continue
  [[ "$dir" == "keyboard" ]] && continue

  src="$PWD/$dir"
  dst="$HOME/.config/$dir"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.backup"
    echo "Backed up $dst → $dst.backup"
  fi

  mkdir -p "$(dirname "$dst")"

  ln -sfn "$src" "$dst"
  echo "Linked $src → $dst"
done
