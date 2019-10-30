# How to test

```
ansible-playbook -i inventory -c local test.yml -e nexus_image_version=3.11.0
```

Options:
- `-i inventory` instructs to use the inventory file (will use localhost)
- `-c local` uses local connection and not ssh
- `-e xxx` any parameter you want to use from the role
