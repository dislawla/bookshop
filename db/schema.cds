namespace sap.capire.bookshop; 

using { Currency, cuid, managed, sap } from '@sap/cds/common';


entity Books : cuid, managed { 
  title  : localized String(111)@mandatory;
  descr  : localized String(1111);
  author : Association to Authors@mandatory @assert.target;
  genre  : Association to Genres;
  stock  : Integer default 0;
  price  : Decimal(9,2);
  currency : Currency;
  change : Integer;
  comit: Boolean;
  rewrite: Boolean;

}

entity Authors : cuid, { 
  name   : String(111);
  books  : Association to many Books on books.author = $self;
}

/** Hierarchically organized Code List for Genres */
entity Genres : cuid, sap.common.CodeList { 
  parent   : Association to Genres;
  children : Composition of many Genres on children.parent = $self;
}

extend Authors with MaagedObject;

aspect MaagedObject{
  createdAt: Timestamp;
  createdBy: String;
  
}
annotate Books with {
  modifiedAt @odata.etag
};
