
Organizational Contacts API
===========================
![Build Status](https://travis-ci.org/skarger/organizational-contacts-api.svg?branch=master)

An HTTP service to provide contact information for one or more organizations, including phone numbers, email addresses, and postal addresses. It supports multiple contact points per organization, to account for variation such as
- Different user needs, like separate customer service and sales contacts.
- Localization, both in terms of supported languages for a given contact and in terms of the area served.

This service intends to act as a data provider such as that described by [https://developers.google.com/structured-data/customize/contact-points](https://developers.google.com/structured-data/customize/contact-points), although it uses the JSON API format rather than JSON-LD.

## Local Installation and Operation
- Clone
- Ensure you have ruby and bundler installed
- `bundle install`
- `bundle exec rackup -p 3000`
- Load http://localhost:3000 in your browser. You will see this service's "home page" JSON API response.

## Design Choices

### JSON API media type
This service responds with the [JSON API media type](http://jsonapi.org/). In the future it may also respond to [JSON-LD](http://json-ld.org/) to cater to search engines and other [schema.org](http://schema.org) compatible parsers.

### schema.org structured data
This service uses semantic descriptors specified by [schema.org](http://schema.org), namely
- [http://schema.org/Organization](http://schema.org/Organization)
- [http://schema.org/ContactPoint](http://schema.org/ContactPoint)
- [http://schema.org/AdministrativeArea](http://schema.org/AdministrativeArea)

### Hypermedia
This service aspires to be a hypermedia API, in the sense that clients may simply request the home page and then dynamically navigate the content using clearly decodable links. As a result specific URLS may change without breaking clients. Furthermore, clients capable of understanding the semantics of Organizations, ContactPoints, and AdministrativeAreas specified by schema.org can process the response content. Therefore this service does not require fully custom-built clients.

This service aspires to leverage HTTP 1.1 semantics extensively, including appropriate response codes, caching headers, and other HTTP features utilized by JSON API.

### Organizations
We represent organizations as collection, but intended use of this service
includes the case when it only contains a single organization.

For example you might start by providing contact points for a single organization, but then it joins with a second organization with its own set of contact info. Depending on the situation, you may want to add the second organization and provide its contact info in a separate context, or alternatively consolidate all the contact info under a single organization. A collection of organizations supports both designs.

### Administrative Areas
Organizations commonly have separate contacts for different countries, states or provinces, cities, or other geographical divisions, and the areaServed value on a ContactPoint allows those distinctions. The value of areaServed value is an AdministrativeArea. As defined by schema.org, an AdministrativeArea is "a geographical region under the jurisdiction of a particular government."

In addition an organization's contacts may have a hierarchy determined by area served. Perhaps people can call local offices in various cities for sales inquires, but they must call a central number at the organization's headquarters for technical support. The containedIn field of an AdministrativeArea caters to that issue. For example a user from Chicago could use the Chicago sales number, and since Chicago is contained in the US the user should call the US technical support number. This service provides the set of AdministrativeAreas associated with an Organization so that clients can build a hierarchy and find the best match for a given contact type.



