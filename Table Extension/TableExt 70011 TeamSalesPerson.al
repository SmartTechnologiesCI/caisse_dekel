tableextension 70011 "Team SalesPerson" extends "Team Salesperson"
{
    fields
    {

        field(70002; "Code commercial"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Salesperson/Purchaser";

        }
        field(70003; "Code peseur"; Code[10])
        {
            DataClassification = ToBeClassified;
            //silué samuel 07/03/2024 TableRelation = "User App";
        }
        // Add changes to table fields here
        field(70000; Utilisateur; Code[50])
        {
            TableRelation = "User Setup"."User ID";
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(70001; "User type"; Option)
        {
            OptionMembers = Commercial,Peseur;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;
        }
        modify("Salesperson Code")
        {

            trigger OnAfterValidate()
            var
                myInt: Integer;
               
            begin
                userSetup.Reset();
                userSetup.SetRange("Salespers./Purch. Code", "Salesperson Code");
                if userSetup.FindFirst() then begin
                    Utilisateur := userSetup."User ID";
                end;
            end;
        }
    }

    keys
    {
        key(Key3; "Code peseur")
        {

        }
    }


    var
        myInt: Integer;
        userSetup: Record "User Setup";

}