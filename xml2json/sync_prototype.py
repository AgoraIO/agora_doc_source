import os
import re
import argparse
import shutil

def sync_prototype(src_dir, dest_dir):
    src_api_dir = os.path.join(src_dir, 'API')
    dest_api_dir = os.path.join(dest_dir, 'API')

    for file_name in os.listdir(src_api_dir):
        if file_name.startswith(('api_', 'callback_', 'class_')):
            src_file = os.path.join(src_api_dir, file_name)
            dest_file = os.path.join(dest_api_dir, file_name)

            with open(src_file, 'r') as file:
                content = file.read()
                pattern = r'<section id="prototype".*?</section>'
                proto = re.findall(pattern, content, flags=re.DOTALL)
                if not proto:
                    print(f"No proto in cn file: {src_file}")
                    continue

            if os.path.exists(dest_file):
                with open(dest_file, 'r+') as file:
                    content = file.read()
                    updated_content = re.sub(r'<section id="prototype".*?</section>', proto[0], content, flags=re.DOTALL)
                    file.seek(0)
                    file.write(updated_content)
                    file.truncate()
            else:
                print(f"No corresponding en file: {dest_file}")

def sync_keysmap(src_dir, dest_dir):
    src_config_dir = os.path.join(src_dir, 'config')
    dest_config_dir = os.path.join(dest_dir, 'config')

    for file_name in os.listdir(src_config_dir):
        if file_name.startswith('keys-rtc-ng-api'):
            src_file = os.path.join(src_config_dir, file_name)
            dest_file = os.path.join(dest_config_dir, file_name)
            shutil.copy2(src_file, dest_file)

def main():
    parser = argparse.ArgumentParser(description="Prototype & Keysmap syncer")
    parser.add_argument("--src_dir", help="source directory", action="store")
    parser.add_argument("--dest_dir", help="destination directory", action="store")
    args = vars(parser.parse_args())
    src_dir = args['src_dir']
    dest_dir = args['dest_dir']

    sync_prototype(src_dir, dest_dir)
    sync_keysmap(src_dir, dest_dir)

if __name__ == '__main__':
    main()