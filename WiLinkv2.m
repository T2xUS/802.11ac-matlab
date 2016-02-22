% BER simulation of VHT SU 802.11 ac 
% Derived from a skeleton BER script for a wireless link simulation encased in human
%function [ber] = WirelessLinkSimulation(MCS)

clear all; close all; clc; format compact;

% warnings that occur when running remotely
warning('off','MATLAB:xlswrite:AddSheet');
warning('off','MATLAB:xlswrite:NoCOMServer');

% Specify SNR range
SNR_Vec = -90:10:20; % in dB

% Specify modulation coding scheme (ranges from 0-9)
MCS = 9;

% The M-ary number, 2 corresponds to binary modulation
msgM = [2 4 16 64 256]; 

% For reference
%{
k = log2(msgM);   % # of information bits per symbol
puncpat = [1; 1; 1; 0;]; % Rate 2/3 Figure 18-9
puncpat = [1; 1; 1; 0; 0; 1;]; % Rate 3/4  Figure 18-9
puncpat = [1; 1; 1; 0; 0; 1; 1; 0; 0; 1;]; % Rate 5/6  Figure 20-11
puncpat = -1;
%}

% Execute BCC encoding and retrieve BERs 
BER_Vec = BCC(SNR_Vec,MCS);
ber = BER_Vec(1,:)

%{
% Compute the theoretical BER for this scenario
SNR_Vec = EbNoEncoderInput;
berHypo = berawgn(SNR_Vec, 'qam', msgM, 'nondiff');
figure
semilogy(SNR_Vec,berHypo,'r')
hold on
semilogy(SNR_Vec,BERVec(1,:));
hold off
legend('Theoretical BER', 'BER');
title(strcat(num2str(msgM), ' QAM'));
filename = sprintf('snr%d_ber%dQAM%dfw%dbk%dk%.3fff%.2fis.csv',snr,QAM,nfwdweights,nfbkweights,Kappa,ff,is);
xlswrite(filename,berVec,'berVec');
filename = sprintf('snr%d_br%dQAM%dfw%dbk%dk%.3fff%.2fis.csv',snr,QAM,nfwdweights,nfbkweights,Kappa,ff,is);
xlswrite(filename,brVec,'brVec');
filename = sprintf('snr%d_ew%dQAM%dfw%dbk%dk%.3fff%.2fis.csv',snr,QAM,nfwdweights,nfbkweights,Kappa,ff,is);
xlswrite(filename,ewVec,'ewVec');
filename = sprintf('snr%d_eqchan%dQAM%dfw%dbk%dk%.3fff%.2fis.csv',snr,QAM,nfwdweights,nfbkweights,Kappa,ff,is);
xlswrite(filename,eqchan,'eqchan');
filename = sprintf('snr%d_eqweights%dQAM%dfw%dbk%dk%.3fff%.2fis.csv',snr,QAM,nfwdweights,nfbkweights,Kappa,ff,is);
xlswrite(filename,eqweights,'eqweights');
%}
%endtime = datetime('now');
