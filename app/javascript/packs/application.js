/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

require("@rails/ujs").start();

import '../src/application.css'

// src/application.js
import { Application } from "stimulus"
import { definitionsFromContext } from "stimulus/webpack-helpers"

const application = Application.start()
const context = require.context("../controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

window.addEventListener('DOMContentLoaded', (event) => {
  // journal days dropdown
  let journalDaysDropdown = document.querySelector('#journal_days_dropdown');

  let handleJournalDaysChange = function(event) {
    var target = event.target;
    var selectedIndex = target.selectedIndex;
    var selectedOption = target.options[selectedIndex];

    window.location.href = selectedOption.value;
  };

  if(journalDaysDropdown !== null) {
    journalDaysDropdown.addEventListener('change', handleJournalDaysChange);
  }

  // .clickable
  let registerClickableEvent = function(element) {
    element.addEventListener('click', function() {
      window.location = element.dataset.href;
    });
  }

  Array.from(document.querySelectorAll('.clickable')).forEach(registerClickableEvent);


  // .js-toggle-actions
  let registerToggleActionsEvent = function(element) {
    element.addEventListener('click', function() {
      var clickedElement = element.parentNode;

      var actionsElement = clickedElement.querySelector('.actions');
      actionsElement.classList.toggle('hidden');
    });
  }

  Array.from(document.querySelectorAll('.js-toggle-actions')).forEach(registerToggleActionsEvent);
});
