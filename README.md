## Hackfest-Flutter
This app aims to simplify the process of finding repositories on GitHub, view the various contributors to the repos, and also allows the user to become a contributor to the desired project.


Kindly consider leaving a :star: if you like the repository and our organisation.


## Getting Started
* Fork it.
* Clone your forked repo and move inside it:\
  `git clone https://github.com/<your-github-username>/<repo-name>.git && cd <repo-name>`

* Checkout to a new branch to work on an issue:\
  `git checkout -b my-amazing-feature`

* Now you can open the project.
* Run `flutter pub get` in the project terminal and get the dependencies.
* Use `flutter run debug` to run the app in your local emulator.
* Once you're all done coding, it's time to open a PR :)
  Run the following commands from the root of the project directory:
  \
  `git add .`\
  `git commit -m "A short description about the feature."`\
  `git push origin <my-amazing-feature>`

Open your forked repo in your browser and then raise a PR to the `master` branch of this repository!


## Contributing

To start contributing, check out [CONTRIBUTING.md](https://github.com/IEEE-VIT/hacktoberfest-flutter/blob/master/CONTRIBUTING.md). New contributors are always welcome to support this project. If you want something gentle to start with, check out issues labelled as `easy` or `good-first-issue`

## License

This project is licensed under [MIT](https://github.com/IEEE-VIT/hacktoberfest-flutter/blob/master/LICENSE)


> [!NOTE]  
> This project is not officially affiliated with DigitalOcean or Hacktoberfest in any manner.
>
# Github Repo Viewer

```mermaid

graph TD;
  subgraph MainApp[<font size=6>App Flow]
    SplashScreen[<font size=6>SplashScreen]
    style SplashScreen fill:brown
    SplashScreen --> Authentication([<font size=5>Authentication - Screen])
    style Authentication fill:indigo
    Authentication --> HomePage([<font size=5>HomePage - Screen])
    HomePage --> MenuButton([<font size=5>HomePage - Drawer Widget Menu])
    style HomePage fill:blue
    MenuButton --> User([<font size=5>Basic User Details])
    style User fill:darkgreen
    MenuButton --> Home([<font size=5>Home - Screen])
    style Home fill:darkgreen
    MenuButton --> Profile([<font size=5>Profile - Screen])
    style Profile fill:darkgreen
    Profile --> ProfileDetails([<font size=5>Profile- Photo
    and Description])
    style ProfileDetails fill:red
    MenuButton --> SignOut([<font size=5>SignOut - Button])
    style SignOut fill:darkgreen
    MenuButton --> ChangeTheme([<font size=5>Change Theme - Button])
    style ChangeTheme fill:darkgreen
    style MenuButton fill:purple
    HomePage --> SearchTab([<font size=5>Search Tab - Screen])
    style SearchTab fill:purple
    SearchTab --> SearchButton([<font size=5>Search prompt, 
    Search - Button])
    style SearchButton fill:darkgreen;
    SearchButton --> RepoCards([<font size=5>Repo Cards - Widget])
    style RepoCards fill:darkgreen;
    RepoCards --> RepoInfo([<font size=5>Repo Information])
    style RepoInfo fill:red;
    RepoCards --> DownArrow([<font size=5>Down Arrow - Button])
    style DownArrow fill:red;
    RepoCards --> BookMark([<font size=5>Bookmark Button])
    style BookMark fill:red;
    DownArrow --> Visit([<font size=5> Visit - Button])
    style Visit fill:orange;
    Visit --> WebVisit([<font size=5> Opens GitHub Page])
    style WebVisit fill:blue;
    DownArrow --> Contributors([<font size=5>Contributors - Button])
    style Contributors fill:orange;
    Contributors --> ContributorsScreen([<font size=5>Contributors - Screen])
    style ContributorsScreen fill:blue;
    ContributorsScreen --> ContributorWidget([<font size=5>Contributor - Widget])
    style ContributorWidget fill:purple;
    ContributorWidget --> ViewProfile([<font size=5>View Profile - Button])
    style ViewProfile fill:darkgreen;
    ViewProfile --> ProfilScreen([<font size=5>Contributor's Profile Screen])
    style ProfilScreen fill:red;
    ContributorWidget --> ContributorInfo([<font size=5>Contributor's Basic details])
    style ContributorInfo fill:darkgreen;
    ContributorsScreen --> Floating([<font size=5>Floating - Button])
    style Floating fill:purple;
    Floating --> ContributorRequest([<font size=5>Requests to be 
    a contributor])
    style ContributorRequest fill:darkgreen;
    HomePage --> BookMarkTab([<font size=5>BookMark Tab - Screen])
    style BookMarkTab fill:purple
    BookMarkTab --> RepoCards
    HomePage --> AboutUsTab([<font size=5>About Us Tab - Screen])
    style AboutUsTab fill:purple
    AboutUsTab --> Corousal([<font size=5>IEEE-VIT Corousal])
    style Corousal fill:darkgreen
    AboutUsTab --> IEEE-VIT-Repos([<font size=5>IEEE-VIT Repo's])
    style IEEE-VIT-Repos fill:darkgreen
    IEEE-VIT-Repos --> RepoCards
    AboutUsTab --> Visit-IEEE-VIT([<font size=5>Visit IEEE GitHub Button])
    style Visit-IEEE-VIT fill:darkgreen
    AboutUsTab --> Contributors-IEEE-VIT([<font size=5>IEEE GitHub 
    Contributors Button])
    style Contributors-IEEE-VIT fill:darkgreen
    AboutUsTab --> Follow([<font size=5> Follow IEEE-VIT
    Button])
    style Follow fill:darkgreen

  end

```
