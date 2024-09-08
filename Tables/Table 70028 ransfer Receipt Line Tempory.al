table 70028 "Transfer Receipt Line Tempory"
{
    DataClassification = ToBeClassified;
    
    fields
    {
        field(50000;"Item Rcpt. Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            
        }
        field(50001; "Transfer Order No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Nombre de carton"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50003; Open; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        
    }
    
    keys
    {
        key(Key1; "Item Rcpt. Entry No.")
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