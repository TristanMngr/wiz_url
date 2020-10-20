## WizUrl

**WizUrl** is a URL shortener it has 3 features:

- Transform an URL in a shortened URL
- Access the website from the shortened URL
- List and delete shortened URLs previously created + display a graph representing the number of accesses per minute T => T-1

The website is accessible on Heroku: [https://wizurl.herokuapp.com/](https://wizurl.herokuapp.com/)

### Stack

- Backend: **Ruby On Rails 6**
- Frontend: **Bootstrap 4**
- Graphique: **Chartkick**
- Herbergement: **Heroku**
- DB: **Postgresql**

### Details

- I have two tables in the DB: `Link` _has_many_ `LinkClick`: each time I click on the shortened link I create a new `LinkClick`, It allows me to count the number of click for one minute
- `LinkForm` is a form object, I could have let the logic in the controller but since I had to generate a random "slug" and some validation on it, I prefer to extract the logic in the form object, moreover It avoids me to have validation in the model
- `GraphLinkPresenter` is a presenter to prepare the data before displaying it with Chartkick

### Improvements

- Create a centralized errors handling object: all the errors are not properly handled and I have some repetitions in the controllers
- Use a front-end framework: some part are asynchrone some not => make everything asynchrone
- Better UX/design

### Sources

- [shortened url](https://www.zauberware.com/en/articles/2019/create-a-url-shortener-with-ruby-on-rails/)
