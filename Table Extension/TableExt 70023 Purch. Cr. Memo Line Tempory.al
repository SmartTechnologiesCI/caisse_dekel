table 70031 "Purch. Cr. Memo Line Tempory"
{
    DataClassification = ToBeClassified;
    
    fields
    {

        field(50000;"Appl.-to Item Entry"; Integer)
        {
            DataClassification = ToBeClassified;
            
        }
        field(50001; "Nombre de carton"; Integer)
        {
            DataClassification = ToBeClassified;
        }
    }
    
    keys
    {
        key(Key1; "Appl.-to Item Entry")
        {
            // Clustered = true;
        }
    }
    
    fieldgroups
    {
        // Add changes to field groups here
    }
    
    var
        myInt: Integer;
    
    trigger OnInsert()
    begin
        
    end;
    
    trigger OnModify()
    begin
        
    end;
    
    trigger OnDelete()
    begin
        
    end;
    
    trigger OnRename()
    begin
        
    end;
    
}