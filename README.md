# VPS and cloud GPU Instance Initialization Scripts

Public helper scripts to quickly initialize remote linux server instances, e.g. [Runpod](https://console.runpod.io/deploy) or various VPS providers

Each script will have its own instructions but generally you can run something like this on the remote:
```sh
curl -sSL https://raw.githubusercontent.com/vijay-prema/instance-init/refs/heads/main/setup_runpod.sh | bash
```

_Note that raw links to github content like above, take some time to update after pushing changes._

## Tips for working with remote instances

- Options for sharing files:
  - Transfer a file or folder using `croc send ...` on the sender, and on the recipient run `croc` and paste the code.
  - Use rsync to one-way sync a large number of data files e.g. `rsync --info=progress2 -r -e "ssh -p 31739 -i ~/.ssh/id_rsa.pub" ./datafiles root@99.80.99.155:/workspace/`, replacing ip address and port.  This would one-way sync the `datafiles` folder and contents to `/workspace/` on the remote.  You can also sync partial subfolders of large datasets, preserving directory structure on remote, by adding `-R` rysnc option, and having a path like `./datafiles/2025/10`. That would just sync the contents of `10` folder to `/workspace/datafiles/2025/10` on remote.
  - Another seamless option for sharing files is mount a SSHFS folder in the remote instance.
  - Some providers may have their own tools which might have extra convenciences but becomes provider specific, so often better to use generic methods mentioned above. e.g. `runpodctl send ...` for runpod instances.
- VS code can remotely work with an instance over SSH. All files will be kept on the instance, and all terminal commands and shells will run on the instance too.  Just hit the blue `><` icon at the bottom left and paste the ssh command. 
