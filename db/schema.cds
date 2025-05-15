namespace sap.capire.bookshop; 

using { Currency, cuid, managed, sap } from '@sap/cds/common';


entity Books : cuid, managed { 
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

entity Authors : cuid, managed { 
  name   : String(111);
  books  : Association to many Books on books.author = $self;
}

/** Hierarchically organized Code List for Genres */
entity Genres : cuid, sap.common.CodeList { 
  parent   : Association to Genres;
  children : Composition of many Genres on children.parent = $self;
}