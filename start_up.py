
import paramiko


def main():
    commands = [
        """sudo apt-get \
            --purge remove \
                xinetd nis yp-tools tftpd atftpd \
                tftpd-hpa telnetd rsh-server \
                rsh-redone-server""",
    ]
    user = 'rock'
    password = 'rock'
    hosts = ['192.168.0.35']
    port = 22

    for h in hosts:
        for command in commands:
            ssh = paramiko.SSHClient()
            ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
            ssh.connect(h, port, user, password)
            
            stdin, stdout, stderr = ssh.exec_command(command)
            lines = stdout.readlines()
            print(lines)


if __name__ == '__main__':
    main()