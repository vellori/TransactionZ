#  TransactionZ

A very simple implementation for list

## Assumptions
- Navigation is done by storyboards and segues, having more complicated requirements can lead to manual segues/Router class
- Locale for tests is set to American
- It's unclear how aggressive/persistent image caching has to be, so I implemented a transient cache with NSCache. With the same approach/method signature a more elaborate cache might be implemented
- Data model is considered rigid: it means if a transaction is breaking the model, the whole list will not be loaded. It's easy to fix this, however in finance "no data" is sometimes better than "wrong data"

## On the making
I've used a simple approach (MVC) with some added steroids to make it testable with reusable components.
All code is separated into reusable classes (mostly injectable), and struct (as business logic container), most of them I've tested.

## What's testable and what's not
Half of the code is tested. Controller is not tested and it's mostly UI, I'd cover that with UI Tests.


## What's not there
- Error states, they are managed but there's no ui for them

## No 3rd party libraries, why?
I could have used a few, especially for image caching. I hope this way you can assess better my skills, plus there is an hint in the challenge about limiting the usage of 3rd party pods.

## UI
When code challenges requires more attention to UI (more navigation, accessibility, dynamic types) I usually spend more time in there, but it didn't seem to be the focus here. 
For example using uistackviews in the tableView would allow an easy localisation for right-to-left writers but localisation is not even mentioned (as well as dynamic type) so I wanted to focus on things that will be evaluated.


