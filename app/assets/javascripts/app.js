$( document ).ready(function() {

    console.log('welcome');

    window.myList = [];

    fetch('/ingredients')
        .then(response => response.json())
        .then(data => {

            let autoCompleteConfig = {
                selector: "#autoComplete",
                placeHolder: "Search for Ingredient...",
                data: {
                    src: data,
                    cache: true
                },
                resultsList: {
                    element: (list, data) => {
                        if (!data.results.length) {
                            // Create "No Results" message element
                            const message = document.createElement("div");
                            // Add class to the created element
                            message.setAttribute("class", "no_result");
                            // Add message text content
                            message.innerHTML = `<span>Found No Results for "${data.query}"</span>`;
                            // Append message element to the results list
                            list.prepend(message);
                        }
                    },
                    noResults: true,
                },
                resultItem: {
                    highlight: {
                        render: true
                    }
                },
                submit: true,
                events: {
                    list: {
                        click: (event) => {
                            console.log(`${event.target.innerText} clicked`);
                            if (event.target.innerText.length < 2) {
                                return false;
                            }
                            autoCompleteJS.close();
                            searchElement.value = "";
                            let e = document.createElement('div');
                            e.classList += "list-item"
                            e.innerText = event.target.innerText
                            document.querySelector(".list-items").appendChild(e);
                            myList.push(event.target.innerText);
                        }
                    }
                }
            }
            const autoCompleteJS = new autoComplete(autoCompleteConfig);

            const searchElement = document.querySelector("#autoComplete");
            searchElement.addEventListener("selection", function (event) {
                // "event.detail" carries the autoComplete.js "feedback" object
                if (event.detail.selection.value.length < 2) {
                    return false;
                }
                console.log("selected " + event.detail.selection.value);
                let e = document.createElement('div');
                e.classList += "list-item"
                e.innerText = event.detail.selection.value;
                document.querySelector(".list-items").appendChild(e);
                myList.push(event.detail.selection.value);
                autoCompleteJS.close();
                searchElement.value = "";
            });
        });

    window.clearList = function () {
        myList = [];
        document.querySelector(".list-items").innerHTML = "";
        document.querySelector(".recipes-container").innerHTML = "";
    }

    window.getRecipes = function () {
        fetch("/recipes", {
            method: 'POST',
            mode: 'cors',
            cache: 'no-cache',
            credentials: 'same-origin',
            headers: {
                'Content-Type': 'application/json'
            },
            redirect: 'follow',
            referrerPolicy: 'no-referrer',
            body: JSON.stringify({ingredients: myList})
        })
            .then(response => response.json())
            .then(data => {
                console.log('Success:', data);
                populateRecipes(data);
            })
    }

    function populateRecipes(data) {
        let container = document.querySelector(".recipes-container")
        data.forEach(recipe =>{
            let recipeElement = document.createElement("div");
            recipeElement.classList += "recipe";
            recipeElement.innerHTML =
                "<div class=\"recipe-ing-container\">" +
                `<div class=\"ing-title\">${recipe.title}</div>` +
                `<div>Author: ${recipe.author}</div>` +
                `<div>Category: ${recipe.category}</div>` +
                `<div>Cook_time: ${recipe.cook_time}</div>` +
                `<div>Cuisine: ${recipe.cuisine}</div>` +
                `<div>Prep time: ${recipe.prep_time}</div>` +
                `<div>Ratings: ${recipe.ratings}</div>` +
                `<div class=\"ing-container\">` +
                "<div class=\"ing-title-2\">Ingredients:</div>" +
                "</div>" +
                "</div>" +
                "<div class=\"img-container\">" +
                `<img src="${recipe.image}">` +
                "</div>"
            container.appendChild(recipeElement);
            let target = recipeElement.querySelector(".ing-title-2");
            recipe.ingredients_desc.forEach(i =>{
                target.insertAdjacentHTML('afterend',`<div>${i}</div>`)
            })


        })
    }
});

