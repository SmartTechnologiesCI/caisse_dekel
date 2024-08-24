page 70080 "Objectif Commercial List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Objectif Commercial";
    CardPageId = "Objectif Commercial card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(No; rec.No)
                {

                }
                field(Groupe; rec.Groupe)
                {

                }
                field(DateDebut; rec.DateDebut) { }
                field(DateFin; rec.DateFin) { }
                field(Status; rec.Status) { }
            }
        }
        area(Factboxes)
        {

        }


    }

    actions
    {
        area(Processing)
        {
            action("Envoyer par mail")
            {

                ApplicationArea = All;
                Caption = 'Envoyez Mail';
                trigger OnAction()
                var
                    sendemail: Codeunit 70003;
                begin
                    if sendemail.Run() then begin
                        Message('Email envoyé verifier vos spams');
                    end;





                end;
            }
            action("Creation Ocommercial")
            {
                Caption = 'Creation objectif commercial';
                ApplicationArea = All;

                trigger OnAction()
                var
                    oc: Record "Objectif Commercial";
                    oc2: Record "Objectif Commercial";
                    oc3: Record "Objectif Commercial";
                    ol: Record "Ligne Ojectif Commercial";
                    team: Record team;
                    cpt: Integer;
                begin
                    oc.DeleteAll();
                    oc2.DeleteAll();
                    oc3.DeleteAll();
                    team.Reset();
                    if team.FindFirst() then begin
                        repeat

                            oc.DateDebut := DMY2Date(01, 03, 2022);
                            oc.DateFin := CalcDate('+1M -1J', DMY2Date(01, 03, 2022));
                            oc.Groupe := team.Code;
                            oc.Insert();


                            oc2.DateDebut := DMY2Date(01, 04, 2022);
                            oc2.DateFin := CalcDate('+1M -1J', DMY2Date(01, 04, 2022));
                            oc2.Groupe := team.Code;
                            oc2.Insert();

                            oc3.DateDebut := DMY2Date(01, 05, 2022);
                            oc3.DateFin := CalcDate('+1M -1J', DMY2Date(01, 05, 2022));
                            oc3.Groupe := team.Code;
                            oc3.Insert();

                        until team.Next() = 0;
                    end;

                end;
            }

            action("Regroupement LOC")
            {
                Caption = 'Regroupement ligne objectif commercial';
                ApplicationArea = All;

                trigger OnAction()
                var
                    oc: Record "Objectif Commercial";
                    loc: Record "Ligne Ojectif Commercial";
                    team: Record Team;
                begin
                    if team.FindFirst() then begin
                        if oc.FindFirst() then begin
                            repeat
                                loc.SetRange("Date debut", DMY2Date(01, 03, 2022), DMY2Date(31, 03, 2022));
                               

                            until oc.Next() = 0;
                        end;
                    end;


                end;
            }

        }
    }

    trigger OnOpenPage()
    var
        myInt: Integer;


    begin

    end;
}