# VPS and cloud GPU Instance Initialization Scripts

Public helper scripts to quickly initialize remote linux server instances, e.g. [Runpod](https://console.runpod.io/deploy) or various VPS providers

Each script will have its own instructions but generally you can run something like:
```
curl -sSL https://raw.githubusercontent.com/vijay-prema/instance-init/refs/heads/main/setup_runpod.sh | bash
```

_Note that raw links to github content like above, take some time to update after pushing changes._

## Tips for working with remote instances

- Transfer a file or folder using `croc send ...` on the sender, and on the recipient run `croc` and paste the code.
- Another seamless option for sharing files is mount a SSHFS folder in the remote instance.
- VS code can remotely work with an instance over SSH. All files will be kept on the instance, and all terminal commands and shells will run on the instance too.  Just hit the blue `><` icon at the bottom left and paste the ssh command. 
