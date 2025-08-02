for entry in * .*; do
  [[ $entry == . || $entry == .. ]] && continue

  src="$PWD/$entry"
  dst="$HOME/.config/$entry"

  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$dst.backup"
    echo "Backed up $dst → $dst.backup"
  fi

  mkdir -p "$(dirname "$dst")"

  ln -sfn "$src" "$dst"
  echo "Linked $src → $dst"
done
