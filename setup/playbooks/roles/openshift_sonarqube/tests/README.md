# How to test

```
ansible-playbook -i inventory -c local test.yml -e sonarqube_image_version=7.0
```

Options:
- `-i inventory` instructs to use the inventory file (will use localhost)
- `-c local` uses local connection and not ssh
- `-e xxx` any parameter you want to use from the role
