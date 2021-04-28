
# BitLocker Drive Encryption

## More info at:
### ENG [docs.microsoft.com](https://docs.microsoft.com/en-us/windows/security/information-protection/bitlocker/bitlocker-group-policy-settings) 
### RU [docs.microsoft.com](https://docs.microsoft.com/ru-RU/windows/security/information-protection/bitlocker/bitlocker-group-policy-settings)
 
---
## Root settings

* #### Store BitLocker recovery information in Active Directory Domain Services (Windoes Server 2008 and Windows Vista) 

``` text
This policy setting allows you to manage the Active Directory Domain Services (AD DS) backup of BitLocker Drive Encryption recovery information. 
This provides an administrative method of recovering data encrypted by BitLocker to prevent data loss due to lack of key information. 
This policy is only applicable to computers running Windows Server 2008 or Windows Vista.
If you enable this policy setting, BitLocker recovery information will be automatically and silently backed up to AD DS when BitLocker is turned on for a computer. 
This policy setting is applied when you turn on BitLocker.
Note: You must first set up appropriate schema extensions and access control settings on the domain before AD DS backup can succeed. 
Consult the BitLocker Drive Encryption Deployment Guide on Microsoft TechNet for more information about setting up AD DS backup for BitLocker.
BitLocker recovery information includes the recovery password and some unique identifier data. 
You can also include a package that contains a BitLocker-protected drive's encryption key. 
This key package is secured by one or more recovery passwords and may help perform specialized recovery when the disk is damaged or corrupted.
```

* Status: **Enable**
* Options: Recovery passwords and key packages

     ``` text
     If you select the option to "Require BitLocker backup to AD DS" BitLocker cannot be turned on unless     computer is connected to the domain and the backup of BitLocker recovery information to AD DS ceeds. 
     This option is selected by default to help ensure that BitLocker recovery is possible. If this option    not selected, AD DS backup is attempted but network or other backup failures do not prevent Locker  setup. 
     Backup is not automatically retried and the recovery password may not have been stored in AD DS ing  BitLocker setup.
     If you disable or do not configure this policy setting, BitLocker recovery information will not be backed up to AD DS.
     Note: Trusted Platform Module (TPM) initialization may be needed during BitLocker setup. Enable the "Turn on TPM backup to Active Directory Domain Services" policy setting in System\Trusted Platform Module Services to ensure that TPM information is also backed up.
     ```

---

* #### Choose default folder for recovery password

```text
This policy setting allows you to specify the default path that is displayed when the BitLocker Drive Encryption setup wizard prompts the user to enter the location of a folder in which to save the recovery password.
This policy setting is applied when you turn on BitLocker.
```

* Status: **Disable**d

     ``` text
    If you enable this policy setting, you can specify the path that will be used as the default folder location    when the user chooses the option to save the recovery password in a folder. You can specify either a fully     qualified path or include the target computer's environment variables in the path. If the path is not valid,    the BitLocker setup wizard will display the computer's top-level folder view.
    If you disable or do not configure this policy setting, the BitLocker setup wizard will display the     computer's top-level folder view when the user chooses the option to save the recovery password in a folder.
    Note: This policy setting does not prevent the user from saving the recovery password in another folder.
     ```

---

* #### Choose how users can recover BitLocker-protected drives (Windows Server 2008 and Windows Vista)

``` text
This policy setting allows you to control whether the BitLocker Drive Encryption setup wizard can display and specify BitLocker recovery options. 
This policy is only applicable to computers running Windows Server 2008 or Windows Vista. 
This policy setting is applied when you turn on BitLocker.

Two recovery options can be used to unlock BitLocker-encrypted data in the absence of the required startup key information.
The user either can type a 48-digit numerical recovery password or insert a USB flash drive containing a 256-bit recovery key.
```

* Status: **Enable**
* Options: Require recovery password (default)
* Options: Require recovery key (default)

     ``` text
    If you enable this policy setting, you can configure the options that the setup wizard displays to users for    recovering BitLocker encrypted data. Saving to a USB flash drive will store the 48-digit recovery password as  a text file and the 256-bit recovery key as a hidden file. Saving to a folder will store the 48-digit    recovery password as a text file. Printing will send the 48-digit recovery password to the default printer.    For example, not allowing the 48-digit recovery password will prevent users from being able to print or save   recovery information to a folder.

    If you disable or do not configure this policy setting, the BitLocker setup wizard will present users with  ways to store recovery options.

    Note: If Trusted Platform Module (TPM) initialization is needed during the BitLocker setup, TPM owner   information will be saved or printed with the BitLocker recovery information.

    Note: The 48-digit recovery password will not be available in FIPS-compliance mode.
     ```

---

* #### Choose drive encryption method and cipher strength

``` text
This policy setting allows you to configure the algorithm and cipher strength used by BitLocker Drive Encryption. This policy setting is applied when you turn on BitLocker. Changing the encryption method has no effect if the drive is already encrypted or if encryption is in progress. Consult the BitLocker Drive Encryption Deployment Guide on Microsoft TechNet for more information about the encryption methods available.
```

* Status: **Enable**
* Options: AES 256-bit with Diffuser

     ``` text
    If you enable this policy setting you will be able to choose an encryption algorithm and key cipher strength for BitLocker to use to encrypt drives.
    If you disable or do not configure this policy setting, BitLocker will use the default encryption method of AES 128-bit with Diffuser or the encryption method specified by the setup script.
     ```

---

* #### Provide the unique identifiers for your organization

``` text
Identification field. The identification field allows you to associate a unique organizational identifier to BitLocker-protected drives. 
This identifier is automatically added to new BitLocker-protected drives and can be updated on existing BitLocker-protected drives using the Manage-BDE command-line tool. 
An identification field is required for management of certificate-based data recovery agents on BitLocker-protected drives and for potential updates to the BitLocker To Go Reader. 
BitLocker will only manage and update data recovery agents when the identification field on the drive matches the value configured in the identification field. 
In a similar manner, BitLocker will only update the BitLocker To Go Reader when the identification field on the drive matches the value configured for the identification field.

The allowed identification field is used in combination with the "Deny write access to removable drives not     protected by BitLocker" policy setting to help control the use of removable drives in your organization. It     is a comma separated list of identification fields from your organization or other external organizations.

You can configure the identification fields on existing drives by using manage-BDE.exe.
```

* Status: **Disable**

     ``` text
    If you enable this policy setting, you can configure the identification field on the BitLocker-protected  drive and any allowed identification field used by your organization.
    When a BitLocker-protected drive is mounted on another BitLocker-enabled computer the identification field  and allowed identification field will be used to determine whether the drive is from an outside organization.
    If you disable or do not configure this policy setting, the identification field is not required.
        Note: Identification fields are required for management of certificate-based data recovery agents on    BitLocker-protected drives. BitLocker will only manage and update certificate-based data recovery agents when  the identification field is present on a drive and is identical to the value configured on the computer. The     identification field can be any value of 260 characters or fewer.
     ```

---

* #### Prevent memory overwrite on restart

``` text
This policy setting controls computer restart performance at the risk of exposing BitLocker secrets. This   policy setting is applied when you turn on BitLocker. BitLocker secrets include key material used to encrypt  data. This policy setting applies only when BitLocker protection is enabled.
```

* Status: **Disable**

     ``` text
    If you enable this policy setting, memory will not be overwritten when the computer restarts. Preventing memory overwrite may improve restart performance but will increase the risk of exposing BitLocker secrets.
    If you disable or do not configure this policy setting, BitLocker secrets are removed from memory when the  computer restarts.
     ```

---
* #### Validate smart card certificate usage rule compliance

``` text
This policy setting allows you to associate an object identifier from a smart card certificate to a BitLocker-protected drive. This policy setting is applied when you turn on BitLocker.
The object identifier is specified in the enhanced key usage (EKU) of a certificate.  BitLocker can identify which certificates may be used to authenticate a user certificate to a BitLocker-protected drive by matching the object identifier in the certificate with the object identifier that is defined by this policy setting.

Default object identifier is 1.3.6.1.4.1.311.67.1.1

Note:  BitLocker does not require that a certificate have an EKU attribute, but if one is configured for the certificate it must be set to an object identifier (OID) that matches the OID configured for BitLocker.    
```

* Status: **Disable**d

     ``` text
    If you enable this policy setting, the object identifier specified in the "Object identifier" box must match the object identifier in the smart card certificate.
    If you disable or do not configure this policy setting, a default object identifier is used. 
     ```

---

## Fixed Data Drives

* #### Configure use of smart cards on fixed data drives

``` text
This policy setting allows you to specify whether smart cards can be used to authenticate user access to the BitLocker-protected fixed data drives on a computer.
```

* Status: **Disable**d

     ``` text
    If you enable this policy setting smart cards can be used to authenticate user access to the drive. You can     require a smart card authentication by selecting the "Require use of smart cards on fixed data drives" check    box.
    If you disable this policy setting, users are not allowed to use smart cards to authenticate their access to    BitLocker-protected fixed data drives.
    If you do not configure this policy setting, smart cards can be used to authenticate user access to a   BitLocker-protected drive

        Note:  These settings are enforced when turning on BitLocker, not when unlocking a drive. BitLocker will    allow unlocking a drive with any of the protectors available on the drive.
     ```

---
* #### Deny write access to fixed drives not protected by BitLocker

``` text
This policy setting determines whether BitLocker protection is required for fixed data drives to be writable on a computer. This policy setting is applied when you turn on BitLocker.
```

* Status: **Disable**d

     ``` text
    If you enable this policy setting, all fixed data drives that are not BitLocker-protected will be mounted as    read-only. If the drive is protected by BitLocker, it will be mounted with read and write access.

    If you disable or do not configure this policy setting, all fixed data drives on the computer will be mounted   with read and write access.
     ```

---
* #### Allow access to BitLocker-protected fixed data drives from earlier versions of Windows

``` text
This policy setting configures whether or not fixed data drives formatted with the FAT file system can be unlocked and viewed on computers running Windows Server 2008, Windows Vista, Windows XP with Service Pack 3 (SP3), or Windows XP with Service Pack 2 (SP2) operating systems.

If this policy setting is enabled or not configured, fixed data drives formatted with the FAT file system can be unlocked on computers running Windows Server 2008, Windows Vista, Windows XP with SP3, or Windows XP with SP2, and their content can be viewed. These operating systems have read-only access to BitLocker-protected drives.
```

* Status: **Enable**
* Options: Do not install BitLocker To Go Reader on FAT formatted fixed drives

     ``` text
     When this policy setting is enabled, select the "Do not install BitLocker To Go Reader on FAT formatted fixed drives" check box to help prevent users from running BitLocker To Go Reader from their fixed drives. 
     If BitLocker To Go Reader (bitlockertogo.exe) is present on a drive that does not have an identification field specified, or if the drive has the same identification field as specified in the "Provide unique identifiers for your organization" policy setting, the user will be prompted to update BitLocker and BitLocker To Go Reader will be deleted from the drive. 
     In this situation, for the fixed drive to be unlocked on computers running Windows Server 2008, Windows Vista, Windows XP with SP3, or Windows XP with SP2, BitLocker To Go Reader must be installed on the computer. 
     If this check box is not selected, BitLocker To Go Reader will be installed on the fixed drive to enable users to unlock the drive on computers running Windows Server 2008, Windows Vista, Windows XP with SP3, or Windows XP with SP2 that do not have BitLocker To Go Reader installed.
     If this policy setting is disabled, fixed data drives formatted with the FAT file system that are BitLocker-protected cannot be unlocked on computers running Windows Server 2008, Windows Vista, Windows XP with SP3, or Windows XP with SP2. Bitlockertogo.exe will not be installed.
     Note: This policy setting does not apply to drives that are formatted with the NTFS file system.
     ```

---
* #### Configure use of passwords on fixed data drives

``` text
This policy setting specifies whether a password is required to unlock BitLocker-protected fixed data drives. If you choose to permit the use of a password, you can require that a password be used, enforce complexity requirements on the password, and configure a minimum length for the password. For the complexity requirement setting to be effective the Group Policy setting "Password must meet complexity requirements" located in Computer Configuration\Windows Settings\Security Settings\Account Policies\Password Policy\ must be also enabled.
        
Note: These settings are enforced when turning on BitLocker, not when unlocking a volume. BitLocker will allow unlocking a drive with any of the protectors available on the drive.
```

* Status: **Enable**
* Options: Allow password complexity
* Options: Minimum password length for fixed data drive: 8

     ``` text
    If you enable this policy setting, users can configure a password that meets the requirements you define.
    To require the use of a password, select "Require password for fixed data drive".
    To enforce complexity   requirements on the password, select "Require complexity".

    When set to "Require complexity" a connection to a domain controller is necessary when BitLocker is enabled to validate the complexity the password.
    When set to "Allow complexity" a connection to a domain controller will be attempted to validate the complexity adheres to the rules set by the policy, but if no domain controllers are found the password will still be accepted regardless of actual password complexity and the drive will be encrypted using that password as a protector.
    When set to "Do not allow complexity", no  password complexity validation will be done.

    Passwords must be at least 8 characters. To configure a greater minimum length for the password, enter the  desired number of characters in the "Minimum password length" box.
    If you disable this policy setting, the user is not allowed to use a password.
    If you do not configure this policy setting, passwords will be supported with the default settings, which do    not include password complexity requirements and require only 8 characters.

    Note: Passwords cannot be used if FIPS-compliance is enabled. The "System cryptography: Use FIPS-compliant  algorithms for encryption, hashing, and signing" policy setting in Computer Configuration\Windows    Settings\Security Settings\Local Policies\Security Options specifies whether FIPS-compliance is enabled.
     ```

---
* #### Choose how BitLocker-protected operating system drives can be recovered

``` text
This policy setting allows you to control how BitLocker-protected fixed data drives are recovered in the absence of the required credentials. This policy setting is applied when you turn on BitLocker.
```

* Status: **Enable**
* Options: Allow data recovery agent (Allow 48-digit recovery password & Allow 256-bit recovery key )
* Options: Omit recovery options from the BitLocker setup wizard
* Options: Save BitLocker recovery information to Active Directory Domain Services (Store recovery password and key packages)

     ``` text
     The "Allow data recovery agent" check box is used to specify whether a data recovery agent can be used with BitLocker-protected fixed data drives. 
     Before a data recovery agent can be used it must be added from the Public Key Policies item in either the Group Policy Management Console or the Local Group Policy Editor. 
     Consult the BitLocker Drive Encryption Deployment Guide on Microsoft TechNet for more information about adding data recovery agents.
     In "Configure user storage of BitLocker recovery information" select whether users are allowed, required, or not allowed to generate a 48-digit recovery password or a 256-bit recovery key.
     Select "Omit recovery options from the BitLocker setup wizard" to prevent users from specifying  recovery options when they enable BitLocker on a drive. This means that you will not be able to  specify which recovery  option to use when you enable BitLocker, instead BitLocker recovery options for  the drive are determined by  the policy setting.
 
     In "Save BitLocker recovery information to Active Directory Doman Services" choose which BitLocker  recovery information to store in AD DS for fixed data drives. If you select "Backup recovery password  and key    package", both the BitLocker recovery password and key package are stored in AD DS. Storing  the key package    supports recovering data from a drive that has been physically corrupted. If you  select "Backup recovery   password only," only the recovery password is stored in AD DS.
 
     Select the "Do not enable BitLocker until recovery information is stored in AD DS for fixed data  drives" check box if you want to prevent users from enabling BitLocker unless the computer is  connected to the domain  and the backup of BitLocker recovery information to AD DS succeeds.
 
     Note: If the "Do not enable BitLocker until recovery information is stored in AD DS for fixed data  drives" check box is selected, a recovery password is automatically generated.
 
     If you enable this policy setting, you can control the methods available to users to recover data from   BitLocker-protected fixed data drives.
 
     If this policy setting is not configured or disabled, the default recovery options are supported for     BitLocker recovery. By default a DRA is allowed, the recovery options can be specified by the user  including the recovery password and recovery key, and recovery information is not backed up to AD DS
    ```

---

## Operating System Drives

* #### Require additional authentication at startup & Require additional authentication at startup (Windows Server 2008 and Windows Vista)

``` text
This policy setting allows you to configure whether BitLocker requires additional authentication each time the computer starts and whether you are using BitLocker with or without a Trusted Platform Module (TPM). This policy setting is applied when you turn on BitLocker.

Note: Only one of the additional authentication options can be required at startup, otherwise a policy error occurs.

If you want to use BitLocker on a computer without a TPM, select the "Allow BitLocker without a compatible TPM" check box. In this mode a USB drive is required for start-up and the key information used to encrypt the drive is stored on the USB drive, creating a USB key. When the USB key is inserted the access to the drive is authenticated and the drive is accessible. If the USB key is lost or unavailable you will need to use one of the BitLocker recovery options to access the drive.

On a computer with a compatible TPM, four types of authentication methods can be used at startup to provide added protection for encrypted data. When the computer starts, it can use only the TPM for authentication, or it can also require insertion of a USB flash drive containing a startup key, the entry of a 4-digit to 20-digit personal identification number (PIN), or both.
```

* Status: **Disable**d

     ``` text
    If you enable this policy setting, users can configure advanced startup options in the BitLocker setup wizard.

    If you disable or do not configure this policy setting, users can configure only basic options on computers     with a TPM.

    Note: If you want to require the use of a startup PIN and a USB flash drive, you must configure BitLocker   settings using the command-line tool manage-bde instead of the BitLocker Drive Encryption setup wizard.
     ```

---
* #### Allow enhanced PINs for startup

``` text
This policy setting allows you to configure whether or not enhanced startup PINs are used with BitLocker.

Enhanced startup PINs permit the use of characters including uppercase and lowercase letters, symbols, numbers, and spaces. This policy setting is applied when you turn on BitLocker.
```

* Status: **Disable**d

     ``` text
    If you enable this policy setting, all new BitLocker startup PINs set will be enhanced PINs.

    If you disable or do not configure this policy setting, enhanced PINs will not be used.

    Note:   Not all computers may support enhanced PINs in the pre-boot environment. It is strongly recommended that users perform a system check during BitLocker setup.
     ```

---
* #### Configure minimum PIN length for startup

``` text
This policy setting allows you to configure a minimum length for a Trusted Platform Module (TPM) startup PIN. This policy setting is applied when you turn on BitLocker. The startup PIN must have a minimum length of 4 digits and can have a maximum length of 20 digits.
```

* Status: **Enable**
* Options: Minimum characters 8

     ``` text
    If you enable this policy setting, you can require a minimum number of digits to be used when setting the startup PIN.

    If you disable or do not configure this policy setting, users can configure a startup PIN of any length between 4 and 20 digits.
     ```

---
* #### Choose how BitLocker-protected operating system drives can be recovered

``` text
This policy setting allows you to control how BitLocker-protected operating system drives are recovered in the absence of the required startup key information. This policy setting is applied when you turn on BitLocker.
he "Allow certificate-based data recovery agent" check box is used to specify whether a data recovery agent can be used with BitLocker-protected operating system drives. Before a data recovery agent can be used it must be added from the Public Key Policies item in either the Group Policy Management Console or the Local Group Policy Editor. Consult the BitLocker Drive Encryption Deployment Guide on Microsoft TechNet for more information about adding data recovery agents.

In "Configure user storage of BitLocker recovery information" select whether users are allowed, required, or not allowed to generate a 48-digit recovery password or a 256-bit recovery key.

Select "Omit recovery options from the BitLocker setup wizard" to prevent users from specifying recovery options when they enable BitLocker on a drive. This means that you will not be able to specify which recovery option to use when you enable BitLocker, instead BitLocker recovery options for the drive are determined by the policy setting.

In "Save BitLocker recovery information to Active Directory Domain Services", choose which BitLocker recovery information to store in AD DS for operating system drives. If you select "Backup recovery password and key package", both the BitLocker recovery password and key package are stored in AD DS. Storing the key package supports recovering data from a drive that has been physically corrupted. If you select "Backup recovery password only," only the recovery password is stored in AD DS.

Select the "Do not enable BitLocker until recovery information is stored in AD DS for operating system drives" check box if you want to prevent users from enabling BitLocker unless the computer is connected to the domain and the backup of BitLocker recovery information to AD DS succeeds.

Note: If the "Do not enable BitLocker until recovery information is stored in AD DS for operating system drives" check box is selected, a recovery password is automatically generated.
```

* Status: **Enable**
* Options: Allow data recovery agent (Allow 48-digit recovery password & Allow 256-bit recovery key )
* Options: Omit recovery options from the BitLocker setup wizard
* Options: Save BitLocker recovery information to Active Directory Domain Services (Store recovery password and key packages)

     ``` text
    If you enable this policy setting, you can control the methods available to users to recover data from  BitLocker-protected operating system drives.

    If this policy setting is disabled or not configured, the default recovery options are supported for    BitLocker recovery. By default a DRA is allowed, the recovery options can be specified by the user including   the recovery password and recovery key, and recovery information is not backed up to AD DS.

     ```

---
* #### Configure TPM platform validation profile

``` text
This policy setting allows you to configure how the computer's Trusted Platform Module (TPM) security hardware secures the BitLocker encryption key. This policy setting does not apply if the computer does not have a compatible TPM or if BitLocker has already been turned on with TPM protection.
```

* Status: **Disable**d

     ``` text
    If you enable this policy setting before turning on BitLocker, you can configure the boot components that the   TPM will validate before unlocking access to the BitLocker-encrypted operating system drive. If any of these  components change while BitLocker protection is in effect, the TPM will not release the encryption key to    unlock the drive and the computer will instead display the BitLocker Recovery console and require that either  the recovery password or recovery key be provided to unlock the drive.

    If you disable or do not configure this policy setting, the TPM uses the default platform validation profile    or the platform validation profile specified by the setup script. A platform validation profile consists of a  set of Platform Configuration Register (PCR) indices ranging from 0 to 23, The default platform validation   profile secures the encryption key against changes to the Core Root of Trust of Measurement (CRTM), BIOS, and     Platform Extensions (PCR 0), the Option ROM Code (PCR 2), the Master Boot Record (MBR) Code (PCR 4), the NTFS   Boot Sector (PCR 8), the NTFS Boot Block (PCR 9), the Boot Manager (PCR 10), and the BitLocker Access Control     (PCR 11). The descriptions of PCR settings for computers that use an Extensible Firmware Interface (EFI) are    different than the PCR settings described for computers that use a standard BIOS. The BitLocker Drive  Encryption Deployment Guide on Microsoft TechNet contains a complete list of PCR settings for both EFI and   standard BIOS.

    Warning: Changing from the default platform validation profile affects the security and manageability of your   computer. BitLocker's sensitivity to platform modifications (malicious or authorized) is increased or     decreased depending upon inclusion or exclusion (respectively) of the PCRs.  
     ```

---

## Removable Data Drives

* ### Control use of BitLocker on removable drives

``` text
This policy setting controls the use of BitLocker on removable data drives. This policy setting is applied when you turn on BitLocker.
```

* Status: **Enable**
* Options: Allow Users to suspend and decrypt BitLocker protection on removable data drives

     ``` text
    When this policy setting is enabled you can select property settings that control how users can configure   BitLocker. Choose "Allow users to apply BitLocker protection on removable data drives" to permit the user to  run the BitLocker setup wizard on a removable data drive. Choose "Allow users to suspend and decrypt     BitLocker on removable data drives" to permit the user to remove BitLocker Drive encryption from the drive or   suspend the encryption while maintenance is performed. Consult the BitLocker Drive Encryption Deployment  Guide on Microsoft TechNet for more information on suspending BitLocker protection.

    If you do not configure this policy setting, users can use BitLocker on removable disk drives.

    If you disable this policy setting, users cannot use BitLocker on removable disk drives.
     ```

---
* #### Configure use of smart cards on removable data drives

``` text
This policy setting allows you to specify whether smart cards can be used to authenticate user access to BitLocker-protected removable data drives on a computer.

If you enable this policy setting smart cards can be used to authenticate user access to the drive. You can require a smart card authentication by selecting the "Require use of smart cards on removable data drives" check box.

Note:  These settings are enforced when turning on BitLocker, not when unlocking a drive. BitLocker will allow unlocking a drive with any of the protectors available on the drive.
```

* Status: **Disable**d

     ``` text
    If you disable this policy setting, users are not allowed to use smart cards to authenticate their access to    BitLocker-protected removable data drives.

    If you do not configure this policy setting, smart cards are available to authenticate user access to a     BitLocker-protected removable data drive.
     ```

---
* #### Deny write access to fixed drives not protected by BitLocker

``` text
This policy setting configures whether BitLocker protection is required for a computer to be able to write data to a removable data drive.
```

* Status: **Disable**d

     ``` text
     If you enable this policy setting, all removable data drives that are not BitLocker-protected will be mounted as read-only. If the drive is protected by BitLocker, it will be mounted with read and write access.

    If the "Deny write access to devices configured in another organization" option is selected, only drives with   identification fields matching the computer's identification fields will be given write access. When a    removable data drive is accessed it will be checked for valid identification field and allowed identification  fields. These fields are defined by the "Provide the unique identifiers for your organization" policy setting.

    If you disable or do not configure this policy setting, all removable data drives on the computer will be   mounted with read and write access.

    Note: This policy setting can be overridden by the policy settings under User Configuration\Administrative  Templates\System\Removable Storage Access. If the "Removable Disks: Deny write access" policy setting is     enabled this policy setting will be ignored.
     ```

---
* #### Allow access to BitLocker-protected fixed data drives from earlier versions of Windows

``` text
This policy setting configures whether or not removable data drives formatted with the FAT file system can be unlocked and viewed on computers running Windows Server 2008, Windows Vista, Windows XP with Service Pack 3 (SP3), or Windows XP with Service Pack 2 (SP2) operating systems.

If this policy setting is enabled or not configured, removable data drives formatted with the FAT file system can be unlocked on computers running Windows Server 2008, Windows Vista, Windows XP with SP3, or Windows XP with SP2, and their content can be viewed. These operating systems have read-only access to BitLocker-protected drives.
```

* Status: **Disable**d

     ``` text
    When this policy setting is enabled, select the "Do not install BitLocker To Go Reader on FAT formatted     removable drives" check box to help prevent users from running BitLocker To Go Reader from their removable  drives. If BitLocker To Go Reader (bitlockertogo.exe) is present on a drive that does not have an    identification field specified, or if the drive has the same identification field as specified in the  "Provide unique identifiers for your organization" policy setting, the user will be prompted to update   BitLocker and BitLocker To Go Reader will be deleted from the drive. In this situation, for the removable     drive to be unlocked on computers running Windows Server 2008, Windows Vista, Windows XP with SP3, or Windows   XP with SP2, BitLocker To Go Reader must be installed on the computer. If this check box is not selected,     BitLocker To Go Reader will be installed on the removable drive to enable users to unlock the drive on  computers running Windows Server 2008, Windows Vista, Windows XP with SP3, or Windows XP with SP2 that do not    have BitLocker To Go Reader installed.

    If this policy setting is disabled, removable data drives formatted with the FAT file system that are   BitLocker-protected cannot be unlocked on computers running Windows Server 2008, Windows Vista, Windows XP    with SP3, or Windows XP with SP2. Bitlockertogo.exe will not be installed.

    Note: This policy setting does not apply to drives that are formatted with the NTFS file system.
     ```

---
* #### Configure use of passwords on removable data drives

``` text
This policy setting specifies whether a password is required to unlock BitLocker-protected removable data drives. If you choose to allow use of a password, you can require a password to be used, enforce complexity requirements, and configure a minimum length. For the complexity requirement setting to be effective the Group Policy setting "Password must meet complexity requirements" located in Computer Configuration\Windows Settings\Security Settings\Account Policies\Password Policy\ must be also enabled.

Note: These settings are enforced when turning on BitLocker, not when unlocking a volume. BitLocker will allow unlocking a drive with any of the protectors available on the drive.
```

* Status: **Disable**d

     ``` text
    If you enable this policy setting, users can configure a password that meets the requirements that you  define. To require the use of a password, select "Require password for removable data drive". To enforce     complexity requirements on the password, select "Require complexity".

    When set to "Require complexity" a connection to a domain controller is necessary when BitLocker is enabled     to validate the complexity the password. When set to "Allow complexity" a connection to a domain controller     will be attempted to validate the complexity adheres to the rules set by the policy, but if no domain   controllers are found the password will still be accepted regardless of actual password complexity and the    drive will be encrypted using that password as a protector. When set to "Do not allow complexity", no  password complexity validation will be done.

    Passwords must be at least 8 characters. To configure a greater minimum length for the password, enter the  desired number of characters in the "Minimum password length" box.

    If you disable this policy setting, the user is not allowed to use a password.

    If you do not configure this policy setting, passwords will be supported with the default settings, which do    not include password complexity requirements and require only 8 characters.

    Note: Passwords cannot be used if FIPS-compliance is enabled. The "System cryptography: Use FIPS-compliant  algorithms for encryption, hashing, and signing" policy setting in Computer Configuration\Windows    Settings\Security Settings\Local Policies\Security Options specifies whether FIPS-compliance is enabled.
     ```

---
* #### Choose how BitLocker-protected removable drives can be recovered

``` text
This policy setting allows you to control how BitLocker-protected removable data drives are recovered in the absence of the required credentials. This policy setting is applied when you turn on BitLocker.

The "Allow data recovery agent" check box is used to specify whether a data recovery agent can be used with BitLocker-protected removable data drives. Before a data recovery agent can be used it must be added from the Public Key Policies item in either the Group Policy Management Console or the Local Group Policy Editor. Consult the BitLocker Drive Encryption Deployment Guide on Microsoft TechNet for more information about adding data recovery agents.

In "Configure user storage of BitLocker recovery information" select whether users are allowed, required, or not allowed to generate a 48-digit recovery password or a 256-bit recovery key.

Select "Omit recovery options from the BitLocker setup wizard" to prevent users from specifying recovery options when they enable BitLocker on a drive. This means that you will not be able to specify which recovery option to use when you enable BitLocker, instead BitLocker recovery options for the drive are determined by the policy setting.

In "Save BitLocker recovery information to Active Directory Domain Services" choose which BitLocker recovery information to store in AD DS for removable data drives. If you select "Backup recovery password and key package", both the BitLocker recovery password and key package are stored in AD DS. If you select "Backup recovery password only" only the recovery password is stored in AD DS.

Select the "Do not enable BitLocker until recovery information is stored in AD DS for removable data drives" check box if you want to prevent users from enabling BitLocker unless the computer is connected to the domain and the backup of BitLocker recovery information to AD DS succeeds.

Note: If the "Do not enable BitLocker until recovery information is stored in AD DS for fixed data drives" check box is selected, a recovery password is automatically generated.
```

* Status: **Enable**
* Options: Allow data recovery agent (Allow 48-digit recovery password & Allow 256-bit recovery key )
* Options: Omit recovery options from the BitLocker setup wizard
* Options: Save BitLocker recovery information to Active Directory Domain Services (Store recovery password and key packages)

     ``` text
    If you enable this policy setting, you can control the methods available to users to recover data from  BitLocker-protected removable data drives.

    If this policy setting is not configured or disabled, the default recovery options are supported for    BitLocker recovery. By default a DRA is allowed, the recovery options can be specified by the user including   the recovery password and recovery key, and recovery information is not backed up to AD DS
     ```

---
