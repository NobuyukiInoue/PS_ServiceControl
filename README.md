# PS_ServiceControl

Starts / Stop/ Display the service containing the specified character string.

## Usage

Start PowerShell with administrator privileges in advance.

```
./ServiceControl.ps1 [ServiceNameString] "[Start | Stop | Status]"
```

### For Example1

```
./ServiceControl.ps1 "Hyper-V" start
```

```
./ServiceControl.ps1 "Hyper-V" stop
```

```
./ServiceControl.ps1 "Hyper-V" status
```


### For Example2

```
./ServiceControl.ps1 "VMware" start
```

```
./ServiceControl.ps1 "VMware" stop
```

```
./ServiceControl.ps1 "VMware" status
```
