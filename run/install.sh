#!/bin/bash
function_name="probat"
script_path=$(pwd)
chmod +x "$script_path/preRun.sh"
user_dir=$(eval echo ~${SUDO_USER})
if grep -q "function $function_name" "$user_dir/.bashrc"; then
  sed -i "s|function $function_name() {.*|function $function_name() { $script_path/preRun.sh \"$script_path\" \"\$*\"; }|" "$user_dir/.bashrc"
  echo "PROBAT atualizado com sucesso. Agora você pode executar '$function_name' em qualquer lugar."
else
  echo "function $function_name() { $script_path/preRun.sh \"$script_path\" \"\$*\"; }" >> "$user_dir/.bashrc"
  echo "PROBAT instalado com sucesso. Agora você pode executar '$function_name' em qualquer lugar."
fi
exec bash