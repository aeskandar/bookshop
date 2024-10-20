using {sap.capire.bookshop as my} from '../db/schema';

service CatalogService @(path: '/browse') {

@readonly entity Books as select from my.Books {*,
author.name as author
} excluding { createdBy, modifiedBy };

// registers/exposes a path for the service and an EVENT for the context in catalog-service.js
@requires: 'authenticated-user'
action submitOrder (book: Books:ID, quantity: Integer);

// this kind of assignment 'book: Books:ID' is a convention over configuration
// by assigning the type type this way we don't only say that it's of the same
// type as the Books.ID field but also implicitly saying that it's one of the
// actual ids in Books table
// and we get the case of a non-exsitent id out of the box responding with 404


@requires: 'authenticated-user'
action sendOrder (book: Books:ID, quantity: Integer)



}