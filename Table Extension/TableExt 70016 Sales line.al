tableextension 70016 "sales line ext" extends "Sales Line"
{
    fields
    {

        field(70000; bip; Text[20])
        {

            trigger OnValidate()
            var
                myInt: Integer;
            begin
                "No." := bip.substring(1, 5);
                poid := bip.Substring(7, 5);
                Evaluate(des, poid);
                Quantity := des;
                rec.Validate("No.");
                rec.Validate("Quantity");

            end;

        }

        field(70002; poid; Text[10])
        {

        }
        field(70003; des; Decimal)
        {


        }
        
    }

    keys
    {

    }

    fieldgroups
    {

    }

    var
        myInt: Integer;
}