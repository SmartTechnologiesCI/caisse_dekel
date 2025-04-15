tableextension 70027 "Purchase Cue" extends "Purchase Cue"
{
    fields
    {
       field(5000; "Ticket du jour"; Integer)
       {
        FieldClass=FlowField;
        CalcFormula=count("Purch. Inv. Header" where ("Document Date"=const()));
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