# Run frontend in own phone 
## What you need to have?
 - Android phone with enabled `Programming options`
   - To get access to this setting you have to go to `Settings -> Information about software` and click few times in `Version number`.
 - In `Programming options` you should have enabled one of this options:
    - `USB debug` if you want to connect your phone to computer with USB cable,
    - `Wireless debug` (only for Android >= 11) for debuging through Wi-Fi. In Android Studio go to `Device Manager -> Pair using Wi-Fi` and follow the instructions.

## How to get backend adres URL?
In terminal type:
```bash
$ ifconfig
```
To get IP adress of your computer in your local network.

Then the backend adress will be
```
http://YOUR_IP_ADRESS_IN_LOCAL_NETWORK:5000
```
For example if your IP adress is `192.168.11.11`, then the backend's adress will be
```
http://192.168.11.11:5000
```

## Change environtment variable in frontend
Remeber to change URL in frontend `.env`!!!
```bash
APDV_BACKEND_URL=http://YOUR_IP_ADRESS_IN_LOCAL_NETWORK:5000/
```

## Phone screen mirroring in computer
If you want to see your phone's screen in your computer, you have to install [scrcpy](https://github.com/Genymobile/scrcpy):

```bash
$ sudo apt install scrcpy
```

Connect your phone to computer via USB cable (make sure that you granded debug access on your phone) and run in terminal:

```
$ scrcpy
```