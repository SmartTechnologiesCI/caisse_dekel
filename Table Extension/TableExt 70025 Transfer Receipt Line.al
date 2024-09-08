tableextension 70025 "Transfer Receipt LineExt" extends "Transfer Receipt Line"
{
    fields
    {
       field(50000; "Nombre de carton"; Decimal)
       {
        DataClassification = ToBeClassified;
       }
    }
    
    keys
    {
        // Add changes to keys here
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
        myInt: Integer;
}