table 70032 Souche
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50000; No; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;

        }
        field(50001; User; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; Code_Souche; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
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