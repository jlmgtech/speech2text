#!/bin/bash

# Define the installation directory
install_dir="/usr/local/bin"

# Get the OpenAI API key from the user
echo "Please enter your OpenAI API key:"
read -r api_key
echo "'$api_key'"

# Save the keys to a file in the home directory
keys_file="$HOME/.openai_keys"
echo "OPENAI_API_KEY=\"$api_key\"" > "$keys_file"

# Test the OpenAI API key by performing a test curl
echo "Testing OpenAI API key..."
#response=$(curl -s -o /dev/null -w "%{http_code}" \

response=$(
curl -s -o /dev/null -w "%{http_code}" \
    -H "Content-Type: application/json" \
    -H "Authorization: Bearer $api_key" \
    -d '{"model":"gpt-3.5-turbo","messages":[{"role":"user","content":"Please say '"'"'test succeeded'"'"' and nothing else."}],"temperature":0}' \
    https://api.openai.com/v1/chat/completions
)

if [ "$response" != "200" ]; then
  echo "Invalid OpenAI API key. Please try again."
  exit 1
fi

# Copy the transcription script to the installation directory
script_file="speech2text"
if [ ! -f $script_file ]; then
    echo "file '$script_file' does not exist to install."
    exit 1
fi
chmod +x "$script_file"
echo "installing the script, this may ask for your sudo credentials:"
sudo cp "$script_file" "$install_dir/"

echo "Installation complete, you may now use speech2text:"
echo "$> speech2text inputfile.mp4 output.txt"
