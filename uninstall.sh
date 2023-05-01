#!/bin/bash
echo "remove ~/.openai_keys?"
select yn in "Remove it" "Leave it alone"; do
    case $yn in
        "Remove it" ) rm -vf ~/.openai_keys; break;;
        "Leave it alone" ) echo "leaving keys file."; break;;
    esac
done

echo "Might need sudo to remove /usr/local/bin/speech2text"
sudo rm -vf /usr/local/bin/speech2text
echo "done!"
