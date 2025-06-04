# HastePasteGaste
A simple local pastebin cum link-shortener client made in Godot. Dead simple. Almost fatally so.
![image](https://github.com/user-attachments/assets/842c7a11-d58f-46e1-96b1-8372af5ff9dd)
![image](https://github.com/user-attachments/assets/73e29aa5-c17b-4c5d-b1cd-055a01a44bde)
![image](https://github.com/user-attachments/assets/3004e803-e4c0-4296-9a8d-34830ca39e59)


## Usage
### Daily Use
After the applet loads:
1. Select the random file name algorithm you would like and how long the link should be
2. Select whether you're pasting text or using it like a link shortener
3. Define a custom file name if you wish
4. Paste the content or the link you're trying to shorten.
5. Click Submit.
6. The prompts on the screen should tell you whether the request was successful or not.
### Setting up the Server
In theory any API end point could be made to work if you configure the client right.
1. Get Python Flask and Python Gunicorn (`flask` and `gunicorn`)
2. Get Python Flask CORS (`flask-cors`)
3. Script your API, or use this [example API](https://hastebin.com/share/urigekeqod.kotlin)

If you want maximum compatibility with the client without having to rescript it:

- The client sends out a dictionary in the Request that contains `filename`, `content` and `is_link`. `filename` is the name of the paste. `content` is the paste content itself, or the link to redirect to if `is_link` is enabled.
- The server sends back a dictionary containing `error`, `success`, `filename`, `link` and `code`. `code` can be used to pre-write error messages. `error` contains an apt description of an error. If no error took place, this is empty. `success` notifies that the request took place successfully. `filename` returns the file name in case of an error. `link` returns the link of the pasted URL.

### Setting up the Client
1. Get Godot `4.4`.
2. Clone this repository using `git clone https://github.com/WinnerWind/godot-pastebin/`
3. Open Godot in that folder.
4. Create folder `secrets` in the project root.
5. Create file `url.txt` in your `secrets` folder.
6. Put the URL as it is in that file.
7. Export for web, for desktop, for whatever.

### Serving Pastes
Simply host the directory in which all your pastes are outputted. An example way of doing this using NGINX is:
```nginx
        server {
                server_name pastes.example.com;
                location / {
                        root /path/to/paste;
                        rewrite ^(/.*)\.html(\?.*)?$ $1$2 permanent; #Gets rid of trailing .html
                        try_files $uri $uri.html $uri/ =404;
                }
        }
```

## Themes
By default the client ships with 3 themes. The `main.tscn` comes with a Theme Generator node which can be used to re-color the current theme with minimal effort.
