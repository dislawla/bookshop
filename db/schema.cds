namespace sap.capire.bookshop; 

using { Currency, managed, sap } from '@sap/cds/common';


entity Books : managed { 
  key ID : Integer;
  title  : localized String(111);
  descr  : localized String(1111);
  author : Association to Authors;
  genre  : Association to Genres;
  stock  : Integer;
  price  : Decimal(9,2);
  currency : Currency;
  change : Integer;
  comit: Boolean;
  rewrite: Boolean;

}

entity Authors : managed { 
  key ID : Integer;
  name   : String(111);
  books  : Association to many Books on books.author = $self;
}

/** Hierarchically organized Code List for Genres */
entity Genres : sap.common.CodeList { 
  key ID   : Integer;
  parent   : Association to Genres;
  children : Composition of many Genres on children.parent = $self;
}