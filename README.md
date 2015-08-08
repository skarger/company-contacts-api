# Company Contacts API

## Run
`bundle exec rackup -p 3000`

## Overview
We represent organizations as collection, but intended use of this service
includes the case when it only contains a single organization.

For example you might start by providing contact points for
a single organization, but then it joins with a second organization with
its own set of contact info.
Depending on the situation, you may want to add the second organization and 
provide its contact info in a separate context, or alternatively consolidate
all the contact info under a single organization. A collection of
organizations supports both designs.

## Administrative Areas

