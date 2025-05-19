
using { sap.capire.bookshop as db } from '../db/schema';

service AdminService @(path: '/admin') {

    entity Books as projection on db.Books;
    entity Authors as projection on db.Authors;

    action submitOrder (book: Books:ID, quantity: Integer)returns{
     stock: Books:stock
  };

}