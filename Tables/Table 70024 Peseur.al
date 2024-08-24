table 70025 "Origine operation"
{
    Caption = 'Origine de opération';

    fields
    {
        field(1; "Origine Code"; Code[50])
        {
            Caption = 'Origine code';
            NotBlank = true;

        }


    }

    keys
    {
        key(Key1; "Origine Code")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
    }
}

