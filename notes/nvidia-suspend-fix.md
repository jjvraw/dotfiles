# NVIDIA Suspend/Resume Fix

System failed to resume properly from suspend state.

- Ubuntu 24.04
- NVIDIA drivers (535-server)
- GPU: Ada Lovelace

### Logs

```
Mar 27 08:31:52 rawbit kernel: NVRM: nvAssertOkFailedNoLog: Assertion failed: Generic Error: Invalid state [NV_ERR_INVALID_STATE] (0x00000040) returned from _kbusMapAperture_GM107(pGpu, pKernelBus, pMemDesc, pVAS, offset, pAperOffset, pLength, flags, pDevice) @ kern_bus_gm107.c:2777
Mar 27 08:31:52 rawbit kernel: [drm:__nv_drm_gem_nvkms_map [nvidia_drm]] *ERROR* [nvidia-drm] [GPU ID 0x00000100] Failed to map NvKmsKapiMemory 0x00000000ba54fa83
```

Incorrectly references GM107.

### Solution

Temporarily save GPU memory state during suspend. Added the following parameters to `/etc/default/grub`:

`GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nouveau.modeset=0 nvidia.NVreg_PreserveVideoMemoryAllocations=1 nvidia.NVreg_TemporaryFilePath=/tmp"`
