import os


def get_parenthesis_position(start_line, end_line, data):
    left_p = right_p = [0, 0]
    left_p_num = right_p_num = 0
    left_p_flag = 0
    for line in range(start_line, end_line):
        for col in range(len(data[line])):
            assert left_p_num - right_p_num >= 0, "wrong parenthsis format!\n"
            if data[line][col] == '(':
                if left_p_flag == 0:
                    left_p = [line, col]
                    left_p_flag = 1
                left_p_num += 1
            if data[line][col] == ')':
                right_p_num += 1
                if left_p_num == right_p_num and left_p_flag == 1:
                    right_p = [line, col]
                    break
    return left_p, right_p


def process_plugin_list(plugins, zshrc):
    new_zsh_data = []
    with open(zshrc, 'r') as zsh:
        zsh_data = zsh.readlines()
        plugins_line = -1 

        # find plugins line
        for line in range(len(zsh_data)):
            line_data = zsh_data[line].lstrip()
            if line_data.startswith('plugins'):
                plugins_line = line
                break
        if plugins_line < 0:
            print("can't find key words plugins\n")
            return
        left_p, right_p = get_parenthesis_position(plugins_line, len(zsh_data), zsh_data)
        new_zsh_data = zsh_data[:left_p[0]] + [zsh_data[left_p[0]][:left_p[1] + 1]] + [plugins] + \
                       [zsh_data[right_p[0]][right_p[1]:]] + zsh_data[right_p[0] + 1:]
    with open(zshrc, 'w') as zsh:
        zsh.writelines(new_zsh_data)


def install_zsh_plugins():
    home_dir = os.getenv('HOME')
    zsh_install_cmd = 'sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"'
    zsh_autosuggestions_cmd = 'git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions'
    if not os.path.exists(os.path.join(home_dir, '.oh-my-zsh')):
        print('installing oh-my-zsh...')
        os.system(zsh_install_cmd)
        assert os.path.exists(os.path.join(home_dir, '.oh-my-zsh')), "can't install oh-my-zsh\nPlease check the connection!\n"
    else:
        print('oh-my-zsh already installed.')
    if not os.path.exists(os.path.join(home_dir, '.oh-my-zsh/custom/plugins/zsh-autosuggestions')):
        os.system(zsh_autosuggestions_cmd)
        assert os.path.exists(os.path.join(home_dir, '.oh-my-zsh/custom/plugins/zsh-autosuggestions')) "can't install zsh_autosuggestions\nPlease check the connection!\n"


if __name__ == '__main__':
    home_dir = os.getenv('HOME')
    plugins = 'git osx extract z colored-man-pages zsh-autosuggestions'
    install_zsh_plugins()
    zsh_file = os.path.join(home_dir, '.zshrc')
    if os.path.exists(zsh_file):
        process_plugin_list(plugins, zsh_file)


