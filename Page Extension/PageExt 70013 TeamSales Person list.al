pageextension 70013 "Team Salespeople " extends "Team Salespeople"
{
    layout
    {
        addfirst(Control1)
        {
  /*           field("User type"; rec."User type")
            {
                trigger OnValidate()
                var
                    myInt: Integer;
                begin

                end;
            }
            field("Code commercial"; rec."Code commercial")
            {
                Editable = rec."User type" = rec."User type"::Commercial;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    rec."Salesperson Code" := Rec."Code commercial";
                    rec.Validate("Salesperson Code");
                    
                end;
            }
            field("Code peseur"; rec."Code peseur")
            {
                Editable = rec."User type" = rec."User type"::Peseur;
                trigger OnValidate()
                var
                    myInt: Integer;
                begin
                    Rec."Salesperson Code" := Rec."Code peseur";
                    rec.Validate("Salesperson Code");
                    
                end;
            } */
            

        }
        // Add changes to page layout here
        addafter("Salesperson Name")
        {
            field(Utilisateur; rec.Utilisateur)
            {

            }

        }
/*         modify("Salesperson Code"){
            Editable = false;
            trigger OnAfterValidate()
            var
                myInt: Integer;
            begin
                
            end;
        } */
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}