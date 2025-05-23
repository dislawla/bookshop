using { sap.capire.bookshop as my } from '../db/schema';

service CatalogService @(path: '/cat') { 

  // @readonly 
  entity Books as select from my.Books {*,
    author.name as author
  } excluding { createdBy, modifiedBy };

  action submitOrder (bookID: Books:ID, quantity: Integer)returns{
     stock: Books:stock
  };
}