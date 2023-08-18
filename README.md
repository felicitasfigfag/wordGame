# wordGame
# Documentation

Word Game App - Felicitas Figueroa

---

### How much time was invested

4 Hours

---

### How was the time distributed

**Concept**: 30m

**Model layer:** 10m

**Views**: 40m

**Game mechanics:**  2 hrs

**Tests**: 30m

**Documentation / Repo / Git** : 10 minutes

---

### Decisions made to solve:

**Random generator:** 

The **getRandomPair()** function randomly picks a word pair from a list. To determine if the translation will be correct or incorrect:

1. A random number between 0 and 1 is generated.
2. If the number is less than or equal to 0.25, a correct pair is chosen, ensuring a 25% probability (with a potential 5% deviation) of getting a correct pair.
3. If the number exceeds 0.25, an incorrect translation from another word is selected for that pair.

The function ensures pairs aren't repeated by using an unshown indices list.

**Architecture**:

For this project, I'm using MVVM because it provides a clear separation between UI and game logic, facilitates testing, and positions us well for future modifications. It's a design pattern I'm quite familiar with, ensuring a more efficient implementation.

**Data persistence:**

I wanted to implement data persistence to save the user's progress since there aren't many word pairs, and I aimed to prevent the repetition of the same words upon re-entry. The app saves the user's progress in attempts and loads them when the app is launched, as well as the indices of words already shown to avoid their repetition. I decided on UserDefaults as it is an efficient way to store lightweight user preferences or settings.

---

### Decisions made because of restricted time:

**Close app**

Given that I couldn't find better solutions to programmatically close the app, I had to use exit(), which might cause issues by interrupting some processes. As a quick fix, I implemented a one-second farewell screen, allowing the app time to finish its processes, particularly UserDefaults.

**UI**

The UI hasn't undergone many changes from the provided mockup. I made the decision not to spend too much time on it but used colors and positioning to guide the user on what to do. I invested a bit more time in providing instructions and ensuring a smoother entry into the app.

---

### What would be the first thing to improve or add if there had been more time

**Animations / UI:** 

It's a fairly straightforward and functional app. Personally, I would prioritize redesigning the app; even if minimalistic or simple, adding a bit more dynamism or interaction with the user through animations would be beneficial.

**Code organization**

As a second implementation, I'd review the code organization. I'm not satisfied with the size of MainVM and feel I could further separate its responsibilities.

**Timer** 

Lastly, I think it's essential to have a timer to notify the user of the remaining time, but I didn't want to exceed the metrics requested for the Professional position.
