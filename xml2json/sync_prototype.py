import os
import re
import argparse

parser = argparse.ArgumentParser(description="Prototype syncer")

parser.add_argument("--src_dir",help="src dir",action="store")
parser.add_argument("--dest_dir", help="dest dir", action="store")

args = vars(parser.parse_args())

src_dir = args['src_dir']
dest_dir = args['dest_dir']

prefixes = ('api_', 'callback_', 'class_')

for file_name in os.listdir(src_dir):

    if file_name.startswith(prefixes):

        cn_path = os.path.join(src_dir, file_name)
        with open(cn_path, 'r') as cn_file:
            cn_file_content = cn_file.read()
            pattern = r'<section id="prototype".*?</section>'
            proto = re.findall(pattern, cn_file_content, flags=re.DOTALL)
            if not proto:
                print(f"No proto in cn file: {cn_path}")
                continue

        en_path = os.path.join(dest_dir, file_name)
        try:
            with open(en_path, 'r+') as en_file:
                en_file_content = en_file.read()
                en_file.seek(0)
                updated_content = re.sub(r'<section id="prototype".*?</section>', proto[0], en_file_content, flags=re.DOTALL)
                en_file.write(updated_content)
                en_file.truncate()
        except FileNotFoundError:
            print(f"No corresponding en file: {en_path}")
            continue