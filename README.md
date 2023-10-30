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

### App Work Flow
```mermaid

flowchart TD;
SplashScreen[Splash Screen]
SplashScreen --> Authentication[Authentication Screen]
Authentication --> HomePage[Home Page Screen]
HomePage --> MenuButton[ Drawer Widget Menu]
MenuButton --> Home[Button: Home]
MenuButton --> Profile[Button: User Profile]
MenuButton --> SignOut[Button: Sign Out]
MenuButton --> ChangeTheme[Button: Change Theme]
HomePage --> SearchButton[Search prompt
Search Button]
SearchButton --> RepoCards[Widget: Repo Cards]
RepoCards --> RepoInfo[Repo Information]
RepoCards --> DownArrow[Button: Down Arrow]
RepoCards --> BookMark[Button: BookMark]
DownArrow --> Visit[ Button: Visit GitHub Page]
Visit --> WebVisit[ Opens GitHub Page]
DownArrow --> Contributors[Button: Contributors List]
Contributors --> ContributorsScreen[Contributors Screen]
ContributorsScreen --> ContributorWidget[Widget: Contributor Info Cards]
ContributorWidget --> ViewProfile[Button: View Profile]
ViewProfile --> ProfilScreen[Contributor's Profile Page]
ContributorWidget --> ContributorInfo[Contributor's Basic details]
ContributorsScreen --> Floating[Button: Floating Action Button]
Floating --> ContributorRequest[Requests to be
a contributor]
HomePage --> BookMarkTab[BookMark Screen]
BookMarkTab --> RepoCards
HomePage --> AboutUsTab[About Us Screen]
AboutUsTab --> IEEE-VIT-Repos[IEEE-VIT Repo's]
IEEE-VIT-Repos --> RepoCards
AboutUsTab --> Visit-IEEE-VIT[Button: Visit IEEE GitHub]
AboutUsTab --> Contributors-IEEE-VIT[Button: Hackfest App Contributors ]

```

## License

This project is licensed under [MIT](https://github.com/IEEE-VIT/hacktoberfest-flutter/blob/master/LICENSE)


> [!NOTE]  
> This project is not officially affiliated with DigitalOcean or Hacktoberfest in any manner.

