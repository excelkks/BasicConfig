import os
import time

home_dir = os.getenv('HOME')
repo = os.path.abspath('.')

zshrc_file = os.path.join(home_dir, '.zshrc')
zshrc_backup = os.path.join(repo, 'zsh/.zshrc')
zsh_backup_cmd = 'cp ' + zshrc_file + ' ' + zshrc_backup
os.system(zsh_backup_cmd)

vimrc_file = os.path.join(home_dir, '.vimrc')
vimrc_backup = os.path.join(repo, 'vim/.vimrc')
vimrc_backup_cmd = 'cp ' + vimrc_file + ' ' + vimrc_backup
os.system(vimrc_backup_cmd)

nvim_file = os.path.join(home_dir, '.config/nvim/init.vim')
nvim_backup = os.path.join(repo, 'vim/nvim/init.vim')
coc_settings = os.path.join(home_dir, '.config/nvim/coc-settings.json')
coc_settings_backup = os.path.join(repo, 'vim/nvim/coc-settings.json')
vimspector_file = os.path.join(home_dir, '.config/nvim/vimspector_sample')
vimspector_backup = os.path.join(repo, 'vim/nvim/vimspector_sample')
nvim_backup_cmd = 'cp ' + nvim_file + ' ' + nvim_backup
coc_backup_cmd = 'cp ' + coc_settings + ' ' + coc_settings_backup
vimspector_backup_cmd = 'cp -rf ' + vimspector_file + ' ' + vimspector_backup
os.system(nvim_backup_cmd)
os.system(coc_backup_cmd)
os.system(vimspector_backup_cmd)



message = time.strftime('自动备份于 %Y年%m月%d日 %H:%M:%S', time.localtime(time.time()))

os.chdir(repo)
print(os.path.abspath('./'))
os.system('git add .')
os.system('git commit -m '+ '\"'  + message + '\"')
os.system('git push')
