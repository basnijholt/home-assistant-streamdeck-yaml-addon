import re
import emoji

def replace_named_emojis(text):
    return emoji.emojize(text)

with open("home-assistant-streamdeck-yaml/DOCS.md", "r", encoding="utf-8") as file:
    content = file.read()

updated_content = replace_named_emojis(content)

with open("home-assistant-streamdeck-yaml/DOCS.md", "w", encoding="utf-8") as file:
    file.write(updated_content)
