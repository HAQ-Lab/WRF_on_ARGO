# WRF on ARGO
Documenting instalation and running WRF on ARGO cluster

# Before you begin
Contact the [ARGO support team]{orcadmin@gmu.edu} to set up your account. Include Lucas in your email to receive access to the HAQ-LAB storage drive.

# HAQ-LAB storage
As of November 2020, the `HAQ-LAB` drive has 1TB of storage space available. It is located at /projects/HAQ_LAB. You can create a symbolic link to your home directory with the command `ln -s /projects/HAQ_LAB HAQ_LAB`.

When you first set up access, create a directory with your username in `HAQ_LAB`. Use: 
```
$ cd HAQ_LAB
$ mkdir YOUR_USERNAME
```

This is your space, but remember that the storage space is shared with the group. Be sure to use the `scratch` space for temporary files, and communicate with group members to ensure everyone has enough space for their work.

# Installing WRF
The process is documented on the Wiki page of this repository.
